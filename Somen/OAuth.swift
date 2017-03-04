//
//  OAuth.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

struct OAuth {
  static func generateHeaderContents(request: URLRequest, credential c: Credential) -> String {
    let nonce = generateNonce()
    let timestamp = "\(Int(Date.init().timeIntervalSince1970))"
    let signature = generateSignature(request: request, credential: c, nonce: nonce, timestamp: timestamp, params: [:])
    let content = "OAuth realm=*, "
      + "oauth_consumer_key=\"\(c.consumerKey.urlEncoded)\", "
      + "oauth_nonce=\"\(nonce.urlEncoded)\", "
      + "oauth_signature=\"\(signature.urlEncoded)\", "
      + "oauth_signature_method=\"HMAC-SHA1\", "
      + "oauth_timestamp=\"\(timestamp.urlEncoded)\", "
      + "oauth_token=\"\(c.accessToken.urlEncoded)\", "
      + "oauth_version=\"1.0\""

    return content
  }
}

private extension OAuth {
  static func generateNonce() -> String {
    return "\(Date.init().timeIntervalSince1970)\(arc4random_uniform(999999))".replacingOccurrences(of: ".", with: "")
  }

  static func generateSignature(request: URLRequest,credential c: Credential, nonce: String, timestamp: String, params: [String: String]) -> String {
    var signatureParams: [String: String] = [
      "oauth_consumer_key": c.consumerKey,
      "oauth_nonce": nonce,
      "oauth_signature_method": "HMAC-SHA1",
      "oauth_timestamp": timestamp,
      "oauth_version": "1.0",
      "oauth_token": c.accessToken,
    ]

    params.forEach { (key, value) in
      signatureParams[key] = value
    }

    let paramsStr = signatureParams.keys.sorted().map { (key) -> String in
      return "\(key)=\(signatureParams[key]!.urlEncoded)"
    }.joined(separator: "&").urlEncoded

    let httpMethod = request.httpMethod!
    let encodedURL = request.url!.absoluteString.urlEncoded

    let signatureBaseStr = "\(httpMethod)&\(encodedURL)&\(paramsStr)"
    let signingKey = "\(c.consumerSecret.urlEncoded)&\(c.accessTokenSecret.urlEncoded)"
    let signature = signatureBaseStr.hmacsha1(key: signingKey).base64EncodedString(options: .lineLength64Characters)

    return signature
  }
}
