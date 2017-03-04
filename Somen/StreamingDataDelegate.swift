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

  let receivedDataHandler: ReceivedDataHandler

  init(receivedDataHandler h: @escaping ReceivedDataHandler) {
    receivedDataHandler = h
  }

  func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
    receivedDataHandler(session, dataTask, data)
  }
}
