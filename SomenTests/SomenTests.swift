//
//  SomenTests.swift
//  SomenTests
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import XCTest
import Nimble
@testable import Somen

class SomenTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func test_generateEnumFromJsonString() {
    let dict = getDict(fromJSONString: "{\"delete\":{\"status\":{\"id\":1234,\"id_str\":\"1234\",\"user_id\":3,\"user_id_str\":\"3\"}}}")

    guard let event = Event.init(rawEvent: dict) else {
      XCTFail()
      return
    }
    expect(event.hashValue).to(equal(Event.deleteStatus(rawEvent: [:]).hashValue))
  }

  func getDict(fromJSONString json: String) -> Event.RawEvent {
    return try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! Event.RawEvent
  }
}

private extension Event {
  var hashValue: Int {
    switch self {
    case .newStatus:
      return 1
    case .deleteStatus:
      return 2
    case .deleteLocation:
      return 3
    case .limitNotice:
      return 4
    case .statusWithheld:
      return 5
    case .userWithheld:
      return 6
    case .stallWarning:
      return 7
    case .userUpdate:
      return 8
    case .friends:
      return 9
    case .directMessage:
      return 10
    case .block:
      return 11
    case .unblock:
      return 12
    case .favorite:
      return 13
    case .unfavorite:
      return 14
    case .follow:
      return 15
    case .unfollow:
      return 16
    case .listCreated:
      return 17
    case .listDestroyed:
      return 18
    case .listUpdated:
      return 19
    case .listMemberAdded:
      return 20
    case .listMemberRemoved:
      return 21
    case .listUserSubscribed:
      return 22
    case .listUserUnsubscribed:
      return 23
    case .quotedTweet:
      return 24
    }
  }
}
