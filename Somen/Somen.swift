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

  fileprivate let credential: Credential

  public init(consumerKey : String,
       consumerSecret : String,
       accessToken : String,
       accessTokenSecret : String) {
    credential = (consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessTokenSecret: accessTokenSecret)
  }

}

public extension Somen {

  func home() -> Observable<Event> {
    let url = URL.init(string: "https://userstream.twitter.com/1.1/user.json")!
    var request = URLRequest.init(url: url)
    let auth = OAuth.generateHeaderContents(request: request, credential: credential)
    let configuration = URLSessionConfiguration.default

    var nextEvent = ""

    return Observable<Data>.create({ (observer) -> Disposable in
      let dataDelegate = StreamingDataDelegate.init(receivedDataHandler: { (session, task, data) in
        observer.onNext(data)
      })
      let session = URLSession.init(configuration: configuration, delegate: dataDelegate, delegateQueue: nil)
      request.allHTTPHeaderFields = ["Authorization": auth]

      let task = session.dataTask(with: request)
      task.resume()

      return Disposables.create()
    })
      // encode data into string
      .map({ (data) -> String in
        guard let receivedStr = String.init(data: data, encoding: .utf8) else {
          throw Error.jsonParseFailed(failedData: data) // TODO 「エンコード失敗」を作る
        }
        return receivedStr
      })

//      return Observable<Int>.interval(1, scheduler: MainScheduler.instance)
//        .map({ (index) -> String in
//          let texts = [
//            "aaaaaaaaaaaaaaaaaaaaaaaaaaa\r\n",
//            "bbbbbbbbbbbbbbbbbbbbbbbbbbb",
//            "ccccccccccccccccccccccccccc",
//          ]
//
//          return texts[index % texts.count]
//        })

//      .do(onNext: { (receivedStr) in
//        print("received: \(receivedStr)")
//        print("----------------")
//      })

      .map({ (str) -> [String] in
        return str.components(separatedBy: "\r\n")
      })
      .scan([], accumulator: { (seed, added) -> [String] in
        guard !added.isEmpty else {
          return []
        }
        guard let first = added.first else {
          return []
        }
        guard first != "" else {
          return []
        }

        if added.count == 1 {
          nextEvent += added.first!
          return []
        }

        var completeJsons: [String] = []
        completeJsons.append(nextEvent + first)

        if let last = added.dropFirst().last {
          nextEvent = last
        }

        added.dropFirst().dropLast().forEach({ (jsonStr) in
          completeJsons.append(jsonStr)
        })

        return completeJsons
      })
      .flatMap({
        Observable.from($0)
      })
      .filter({ $0 != "" })
//      .do(onNext: { (str) in
//        print("received: \"\(str)\"")
//      })
      .map({ (str) -> Data in
        guard let data = str.data(using: .utf8) else {
          throw NSError.init()
        }
        return data
      })

      .map({ (data) -> Event in
        guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? Event.RawEvent else {
          throw Error.jsonParseFailed(failedData: data)
        }
        guard let event = Event.init(rawEvent: jsonDict) else {
          throw Event.Error.mappingFailed(rawEvent: jsonDict)
        }

        return event
      })
  }

}

public extension Somen {
  public enum Error: Swift.Error {
    case jsonParseFailed(failedData: Data)
  }
}
