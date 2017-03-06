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

  func test_parseStreamingEvent() {

    let patterns: [Event] = [
      .newStatus(rawEvent: [:]),
      .directMessage(rawEvent: [:]),
      .deleteStatus(rawEvent: [:]),
      .deleteLocation(rawEvent: [:]),
      .limitNotice(rawEvent: [:]),
      .statusWithheld(rawEvent: [:]),
      .userWithheld(rawEvent: [:]),
      .stallWarning(rawEvent: [:]),
      .userUpdate(rawEvent: [:]),
      .friends(rawEvent: [:]),
      .friends(rawEvent: [:]),
      .block(rawEvent: [:]),
      .unblock(rawEvent: [:]),
      .favorite(rawEvent: [:]),
      .unfavorite(rawEvent: [:]),
      .follow(rawEvent: [:]),
      .unfollow(rawEvent: [:]),
      .listCreated(rawEvent: [:]),
      .listDestroyed(rawEvent: [:]),
      .listUpdated(rawEvent: [:]),
      .listMemberAdded(rawEvent: [:]),
      .listMemberRemoved(rawEvent: [:]),
      .listUserSubscribed(rawEvent: [:]),
      .listUserUnsubscribed(rawEvent: [:]),
      .quotedTweet(rawEvent: [:]),
    ]

    patterns.enumerated().forEach { (index, pattern) in
      guard let sampleJson = pattern.sampleJson else {
        return
      }
      let dict = getDict(fromJSONString: sampleJson)
      guard let event = Event.init(rawEvent: dict) else {
        fail("Failed to parse pattern \(index). Json is \(sampleJson)")
        return
      }
      expect(event.hashValue).to(equal(pattern.hashValue))
    }
  }
}

private extension SomenTests {
  func getDict(fromJSONString json: String) -> Event.RawEvent {
    return try! JSONSerialization.jsonObject(with: json.data(using: .utf8)!, options: []) as! Event.RawEvent
  }
}

private extension Event {
  var sampleJson: String? {
    switch self {
    case .newStatus:
      return "{\"created_at\":\"Mon Mar 06 13:22:23 +0000 2017\",\"id\":838741550951649300,\"id_str\":\"838741550951649280\",\"text\":\"テストかいてる\",\"source\":\"aaa\",\"truncated\":false,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":null,\"in_reply_to_screen_name\":null,\"user\":{\"id\":2338703922,\"id_str\":\"2338703922\",\"name\":\"hello\",\"screen_name\":\"hiragram\",\"location\":null,\"url\":\"https://hiragram.github.io\",\"description\":\"description\",\"protected\":false,\"verified\":false,\"followers_count\":562,\"friends_count\":246,\"listed_count\":20,\"favourites_count\":1223,\"statuses_count\":21895,\"created_at\":\"Tue Feb 11 17:17:52 +0000 2014\",\"utc_offset\":32400,\"time_zone\":\"Tokyo\",\"geo_enabled\":false,\"lang\":\"ja\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"FFF2F9\",\"profile_background_image_url\":\"http://abs.twimg.com/images/themes/theme17/bg.gif\",\"profile_background_image_url_https\":\"https://abs.twimg.com/images/themes/theme17/bg.gif\",\"profile_background_tile\":false,\"profile_link_color\":\"01A0C8\",\"profile_sidebar_border_color\":\"C0DEED\",\"profile_sidebar_fill_color\":\"DDEEF6\",\"profile_text_color\":\"333333\",\"profile_use_background_image\":true,\"profile_image_url\":\"http://pbs.twimg.com/profile_images/790358777669103616/ekasI88Y_normal.jpg\",\"profile_image_url_https\":\"https://pbs.twimg.com/profile_images/790358777669103616/ekasI88Y_normal.jpg\",\"profile_banner_url\":\"https://pbs.twimg.com/profile_banners/2338703922/1487747660\",\"default_profile\":false,\"default_profile_image\":false,\"following\":null,\"follow_request_sent\":null,\"notifications\":null},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"is_quote_status\":false,\"retweet_count\":0,\"favorite_count\":0,\"entities\":{\"hashtags\":[],\"urls\":[],\"user_mentions\":[],\"symbols\":[]},\"favorited\":false,\"retweeted\":false,\"filter_level\":\"low\",\"lang\":\"ja\",\"timestamp_ms\":\"1488806543468\"}"
    case .deleteStatus:
      return "{\"delete\":{\"status\":{\"id\":1234,\"id_str\":\"1234\",\"user_id\":3,\"user_id_str\":\"3\"}}}"
    case .deleteLocation:
      return "{\"scrub_geo\":{\"user_id\":14090452,\"user_id_str\":\"14090452\",\"up_to_status_id\":23260136625,\"up_to_status_id_str\":\"23260136625\"}}"
    case .limitNotice:
      return "{\"limit\":{\"track\":1234}}"
    case .statusWithheld:
      return "{\"status_withheld\":{\"id\":1234567890,\"user_id\":123456,\"withheld_in_countries\":[\"DE\",\"AR\"]}}"
    case .userWithheld:
      return "{\"user_withheld\":{\"id\":123456,\"withheld_in_countries\":[\"DE\",\"AR\"]}}"
    case .stallWarning:
      return "{\"warning\":{\"code\":\"FALLING_BEHIND\",\"message\":\"Your connection is falling behind and messages are being queued for delivery to you. Your queue is now over 60% full. You will be disconnected when the queue is full.\",\"percent_full\":60}}"
    case .userUpdate:
      return "{\"created_at\":\"Tue Aug 06 02:23:21 +0000 2013\",\"source\":{},\"target\":{},\"event\":\"user_update\"}"
    case .friends:
      return "{\"friends\":[1497,169686021,790205,15211564]}"
    case .directMessage:
      return "{        \"created_at\": \"Mon Aug 27 17:21:03 +0000 2012\",        \"entities\": {            \"hashtags\": [],            \"urls\": [],            \"user_mentions\": []        },        \"id\": 240136858829479936,        \"id_str\": \"240136858829479936\",        \"recipient\": {            \"contributors_enabled\": false,            \"created_at\": \"Thu Aug 23 19:45:07 +0000 2012\",            \"default_profile\": false,            \"default_profile_image\": false,            \"description\": \"Keep calm and test\",            \"favourites_count\": 0,            \"follow_request_sent\": false,            \"followers_count\": 0,            \"following\": false,            \"friends_count\": 10,            \"geo_enabled\": true,            \"id\": 776627022,            \"id_str\": \"776627022\",            \"is_translator\": false,            \"lang\": \"en\",            \"listed_count\": 0,            \"location\": \"San Francisco, CA\",            \"name\": \"Mick Jagger\",            \"notifications\": false,            \"profile_background_color\": \"000000\",            \"profile_background_image_url\": \"http://a0.twimg.com/profile_background_images/644522235/cdjlccey99gy36j3em67.jpeg\",            \"profile_background_image_url_https\": \"https://si0.twimg.com/profile_background_images/644522235/cdjlccey99gy36j3em67.jpeg\",            \"profile_background_tile\": true,            \"profile_image_url\": \"http://a0.twimg.com/profile_images/2550226257/y0ef5abcx5yrba8du0sk_normal.jpeg\",            \"profile_image_url_https\": \"https://si0.twimg.com/profile_images/2550226257/y0ef5abcx5yrba8du0sk_normal.jpeg\",            \"profile_link_color\": \"000000\",            \"profile_sidebar_border_color\": \"000000\",            \"profile_sidebar_fill_color\": \"000000\",            \"profile_text_color\": \"000000\",            \"profile_use_background_image\": false,            \"protected\": false,            \"screen_name\": \"s0c1alm3dia\",            \"show_all_inline_media\": false,            \"statuses_count\": 0,            \"time_zone\": \"Pacific Time (US & Canada)\",            \"url\": \"http://cnn.com\",            \"utc_offset\": -28800,            \"verified\": false        },        \"recipient_id\": 776627022,        \"recipient_screen_name\": \"s0c1alm3dia\",        \"sender\": {            \"contributors_enabled\": true,            \"created_at\": \"Sat May 09 17:58:22 +0000 2009\",            \"default_profile\": false,            \"default_profile_image\": false,            \"description\": \"I taught your phone that thing you like.  The Mobile Partner Engineer @Twitter. \",            \"favourites_count\": 584,            \"follow_request_sent\": false,            \"followers_count\": 10621,            \"following\": false,            \"friends_count\": 1181,            \"geo_enabled\": true,            \"id\": 38895958,            \"id_str\": \"38895958\",            \"is_translator\": false,            \"lang\": \"en\",            \"listed_count\": 190,            \"location\": \"San Francisco\",            \"name\": \"Sean Cook\",            \"notifications\": false,            \"profile_background_color\": \"1A1B1F\",            \"profile_background_image_url\": \"http://a0.twimg.com/profile_background_images/495742332/purty_wood.png\",            \"profile_background_image_url_https\": \"https://si0.twimg.com/profile_background_images/495742332/purty_wood.png\",            \"profile_background_tile\": true,            \"profile_image_url\": \"http://a0.twimg.com/profile_images/1751506047/dead_sexy_normal.JPG\",            \"profile_image_url_https\": \"https://si0.twimg.com/profile_images/1751506047/dead_sexy_normal.JPG\",            \"profile_link_color\": \"2FC2EF\",            \"profile_sidebar_border_color\": \"181A1E\",            \"profile_sidebar_fill_color\": \"252429\",            \"profile_text_color\": \"666666\",            \"profile_use_background_image\": true,            \"protected\": false,            \"screen_name\": \"theSeanCook\",            \"show_all_inline_media\": true,            \"statuses_count\": 2608,            \"time_zone\": \"Pacific Time (US & Canada)\",            \"url\": null,            \"utc_offset\": -28800,            \"verified\": false        },        \"sender_id\": 38895958,        \"sender_screen_name\": \"theSeanCook\",        \"text\": \"booyakasha\"    }"
    case .block:
      return "{\"event\":\"block\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .unblock:
      return "{\"event\":\"unblock\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .favorite:
      return "{\"event\":\"favorite\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .unfavorite:
      return "{\"event\":\"unfavorite\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .follow:
      return "{\"event\":\"follow\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .unfollow:
      return "{\"event\":\"unfollow\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listCreated:
      return "{\"event\":\"list_created\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listDestroyed:
      return "{\"event\":\"list_destroyed\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listUpdated:
      return "{\"event\":\"list_updated\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listMemberAdded:
      return "{\"event\":\"list_member_added\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listMemberRemoved:
      return "{\"event\":\"list_member_removed\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listUserSubscribed:
      return "{\"event\":\"list_user_subscribed\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .listUserUnsubscribed:
      return "{\"event\":\"list_user_unsubscribed\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    case .quotedTweet:
      return "{\"event\":\"quoted_tweet\",\"created_at\":\"Sat Sep 4 16:10:54 +0000 2010\",\"target\":{},\"source\":{},\"target_object\":{}}"
    }
  }

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
