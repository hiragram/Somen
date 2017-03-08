//
//  OAuthTests.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/08.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import XCTest
import Nimble
@testable import Somen

class OAuthTests: XCTestCase {
  func test_generateAuthotization() {
    let credential = (consumerKey: "30RiR9yC9MWBR9BQqglprVg1R",
                      consumerSecret: "ByLCSDqPNFGAtrGA8VU71nrAkCUUfr26hjXG3kxaoVgEwrjLAC",
                      accessToken: "2338703922-RcdTl0IUlRvEhpyZIEdpGIT3znx1NK4IdtM9clK",
                      accessTokenSecret: "jxuzRUNF7gSqnqyRsgpAqLoTlcqivUiGRkx4QQPXyPiSv"
                      )

    let url = URL.init(string: "https://userstream.twitter.com/1.1/user.json")!
    let request = URLRequest.init(url: url)
    let auth = OAuth.generateHeaderContents(request: request, credential: credential, timestamp: 1488946604, nonce: "testnonce")

    let expected = "OAuth realm=*, oauth_consumer_key=\"30RiR9yC9MWBR9BQqglprVg1R\", oauth_nonce=\"testnonce\", oauth_signature=\"qm9lgFNgKqPzFIZ%2BXTzSnten%2BN8%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1488946604\", oauth_token=\"2338703922-RcdTl0IUlRvEhpyZIEdpGIT3znx1NK4IdtM9clK\", oauth_version=\"1.0\""

    expect(auth).to(equal(expected))
  }
}
