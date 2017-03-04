//
//  URLSessionDataDelegateProxy.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class URLSessionDataDelegateProxy: DelegateProxy, DelegateProxyType, URLSessionDelegate {
  static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
    let session = object as! URLSession
    return session.delegate
  }

  static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
    var session = object as! URLSession
    session.delegate = delegate as? URLSessionDataDelegate
  }
}
