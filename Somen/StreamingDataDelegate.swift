//
//  StreamingDataDelegate.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/05.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

class StreamingDataDelegate: NSObject, URLSessionDataDelegate {

  typealias ReceivedDataHandler = (URLSession, URLSessionDataTask, Data) -> ()
  typealias ErrorHandler = (Error?) -> ()

  let receivedDataHandler: ReceivedDataHandler
  let errorHandler: ErrorHandler

  init(receivedDataHandler h: @escaping ReceivedDataHandler, errorHandler eh: @escaping ErrorHandler) {
    receivedDataHandler = h
    errorHandler = eh
  }

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    receivedDataHandler(session, dataTask, data)
  }

  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    errorHandler(error)
  }
}
