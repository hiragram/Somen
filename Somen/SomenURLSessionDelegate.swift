//
//  SomenURLSessionDelegate.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

class SomenURLSessionDelegate: NSObject, URLSessionDelegate {
  func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {

  }

  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    
  }
}
