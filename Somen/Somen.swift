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

  fileprivate let urlSessionDelegate = SomenURLSessionDelegate.init()

  init(consumerKey : String,
       consumerSecret : String,
       accessToken : String,
       accessTokenSecret : String) {
    credential = (consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessTokenSecret: accessTokenSecret)
  }

}

public extension Somen {

  func home() -> Observable<[String: Any]> {
    let configuration = URLSessionConfiguration.default
    let session = URLSession.init(configuration: configuration, delegate: urlSessionDelegate, delegateQueue: nil)
    let url = URL.init(string: "https://userstream.twitter.com/1.1/user.json")!
    var request = URLRequest.init(url: url)
    let auth = OAuth.generateHeaderContents(request: request, credential: credential)
    request.allHTTPHeaderFields = ["Authorization": auth]

    return session.rx.data(request: request)
      .map({ (data) -> [String: Any] in
        return try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
    })
  }

}
