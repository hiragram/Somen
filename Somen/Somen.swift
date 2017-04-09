//
//  Somen.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal typealias Credential = (consumerKey: String, consumerSecret: String, accessToken: String, accessTokenSecret: String)


public class Somen {

  fileprivate var userstreamObservable: Observable<SomenEvent>?

  fileprivate let credential: Credential

  public init(consumerKey : String,
       consumerSecret : String,
       accessToken : String,
       accessTokenSecret : String) {
    credential = (consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessTokenSecret: accessTokenSecret)
  }

}

public extension Somen {

  func userstream() -> Observable<SomenEvent> {
    if let shared = userstreamObservable {
      return shared
    }
    let url = URL.init(string: "https://userstream.twitter.com/1.1/user.json")!
    var request = URLRequest.init(url: url)
    let auth = OAuth.generateHeaderContents(request: request, credential: credential)
    let configuration = URLSessionConfiguration.default

    let shared = Observable<Data>.create({ (observer) -> Disposable in
      let dataDelegate = StreamingDataDelegate.init(receivedDataHandler: { (session, task, data) in
        observer.onNext(data)
      }, errorHandler: { [weak self] (error) in
        self?.userstreamObservable = nil
        if let error = error {
          observer.onError(error)
        } else {
          observer.onError(NSError.init(domain: "Connection Error", code: 0, userInfo: [:]))
        }
      })
      let session = URLSession.init(configuration: configuration, delegate: dataDelegate, delegateQueue: nil)
      request.allHTTPHeaderFields = ["Authorization": auth]

      let task = session.dataTask(with: request)
      task.resume()

      return Disposables.create {
        task.cancel()
      }
    })
      .map({ (data) -> String in
        guard let receivedStr = String.init(data: data, encoding: .utf8) else {
          throw Error.jsonParseFailed(failedData: data) // TODO 「エンコード失敗」を作る
        }
        return receivedStr
      })
      .pollUntilNewline()
      .map({ (str) -> Data in
        guard let data = str.data(using: .utf8) else {
          throw NSError.init()
        }
        return data
      })
      .map({ (data) -> SomenEvent in
        guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? SomenEvent.RawEvent else {
          throw Error.jsonParseFailed(failedData: data)
        }
        if jsonDict.keys.contains("disconnect") {
          throw StreamError.init(rawError: jsonDict)
        }

        return SomenEvent.init(rawEvent: jsonDict)
      })
    .retry()
    .share()

    userstreamObservable = shared

    return shared
  }

}

public extension Somen {
  public enum Error: Swift.Error {
    case jsonParseFailed(failedData: Data)
  }
}
