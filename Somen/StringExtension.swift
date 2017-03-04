//
//  StringExtension.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import Crypto

extension String {
  var urlEncoded: String {
    var allowedCharacterSet = CharacterSet.alphanumerics
    allowedCharacterSet.insert(charactersIn: "-._~")
    return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)!
  }

  func hmacsha1(key: String) -> Data {
    let dataToDigest = data(using: .utf8)!
    let secretKey = key.data(using: .utf8)!
    return HMAC.sign(data: dataToDigest, algorithm: .sha1, key: secretKey)
  }
}
