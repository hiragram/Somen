//
//  ObservableExtensionTests.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/08.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import XCTest
import RxSwift
import Nimble
@testable import Somen

class ObservableExtensionTests: XCTestCase {

  private let bag = DisposeBag.init()

  func test_pollUntilNewline() {

    var strs: [String] = []

    Observable<String>.from([
      "{\"created_at\":\"Mon Mar 06 13:22:23 +0000 2017\",\"id\":838741550951649300,\"id_str\":\"838741550951649280\",\"text\":\"テストかいてる\",\"source\":\"aaa\",\"truncated\":false,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":nu",
      "ll,\"in_reply_to_screen_name\":null,\"user\":{\"id\":2338703922,\"id_str\":\"2338703922\",\"name\":\"hello\",\"screen_name\":\"hiragram\",\"location\":null,\"url\":\"https://hiragram.github.io\",\"description\":\"description\",\"protected\":false,\"verified\":false,\"followers_count\":562,\"friends_count\":246,\"listed_count\":20,\"favourites_count\":1223,\"statuses_count\":21895,\"created_at\":\"Tue Feb 11 17:17:52 +0000 2014\",\"utc_offset\":32400,\"time_zone\":\"Tokyo\",\"geo_enabled\":false,\"lang\":\"ja\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"FFF2F9\",\"profile_background_image_url\":\"http://abs.twimg.com/images/themes/theme17/bg.gif\",\"profile_background_image_url_https\":\"https://abs.twimg.com/images/themes/theme17/bg.gif\",\"profile_background_tile\":false,\"profile_link_color\":\"01A0C8\",\"profile_sidebar_bord",
      "er_color\":\"C0DEED\",\"profile_sidebar_fill_color\":\"DDEEF6\",\"profile_text_color\":\"333333\",\"profile_use_background_image\":true,\"profile_image_url\":\"http://pbs.twimg.com/profile_images/790358777669103616/ekasI88Y_normal.jpg\",\"profile_image_url_https\":\"https://pbs.twimg.com/profile_images/790358777669103616/ekasI88Y_normal.jpg\",\"profile_banner_url\":\"https://pbs.twimg.com/profile_banners/2338703922/1487747660\",\"default_profile\":false,\"default_profile_image\":false,\"following\":null,\"follow_request_sent\":null,\"notifications\":null},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"is_quote_status\":false,\"retweet_count\":0,\"favorite_count\":0,\"entities\":{\"hashtags\":[],\"urls\":[],\"user_mentions\":[],\"symbols\":[]},\"favorited\":false,\"retweeted\":false,\"filter_level\":\"low\",\"lang\":\"ja\",\"timestamp_ms\":\"1488806543468\"}\r\n",
      "{\"delete\":{\"status\":{\"id\":1234,\"id_str\":\"1234\",\"user_id\":3,\"user_id_str\":\"3\"}}}\r\n"
      ])
    .pollUntilNewline()
    .subscribe(onNext: { (str) in
      strs.append(str)
    }).addDisposableTo(bag)

    expect(strs.count).toEventually(equal(2), timeout: 1)
    expect(strs[0]).toEventually(equal("{\"created_at\":\"Mon Mar 06 13:22:23 +0000 2017\",\"id\":838741550951649300,\"id_str\":\"838741550951649280\",\"text\":\"テストかいてる\",\"source\":\"aaa\",\"truncated\":false,\"in_reply_to_status_id\":null,\"in_reply_to_status_id_str\":null,\"in_reply_to_user_id\":null,\"in_reply_to_user_id_str\":null,\"in_reply_to_screen_name\":null,\"user\":{\"id\":2338703922,\"id_str\":\"2338703922\",\"name\":\"hello\",\"screen_name\":\"hiragram\",\"location\":null,\"url\":\"https://hiragram.github.io\",\"description\":\"description\",\"protected\":false,\"verified\":false,\"followers_count\":562,\"friends_count\":246,\"listed_count\":20,\"favourites_count\":1223,\"statuses_count\":21895,\"created_at\":\"Tue Feb 11 17:17:52 +0000 2014\",\"utc_offset\":32400,\"time_zone\":\"Tokyo\",\"geo_enabled\":false,\"lang\":\"ja\",\"contributors_enabled\":false,\"is_translator\":false,\"profile_background_color\":\"FFF2F9\",\"profile_background_image_url\":\"http://abs.twimg.com/images/themes/theme17/bg.gif\",\"profile_background_image_url_https\":\"https://abs.twimg.com/images/themes/theme17/bg.gif\",\"profile_background_tile\":false,\"profile_link_color\":\"01A0C8\",\"profile_sidebar_border_color\":\"C0DEED\",\"profile_sidebar_fill_color\":\"DDEEF6\",\"profile_text_color\":\"333333\",\"profile_use_background_image\":true,\"profile_image_url\":\"http://pbs.twimg.com/profile_images/790358777669103616/ekasI88Y_normal.jpg\",\"profile_image_url_https\":\"https://pbs.twimg.com/profile_images/790358777669103616/ekasI88Y_normal.jpg\",\"profile_banner_url\":\"https://pbs.twimg.com/profile_banners/2338703922/1487747660\",\"default_profile\":false,\"default_profile_image\":false,\"following\":null,\"follow_request_sent\":null,\"notifications\":null},\"geo\":null,\"coordinates\":null,\"place\":null,\"contributors\":null,\"is_quote_status\":false,\"retweet_count\":0,\"favorite_count\":0,\"entities\":{\"hashtags\":[],\"urls\":[],\"user_mentions\":[],\"symbols\":[]},\"favorited\":false,\"retweeted\":false,\"filter_level\":\"low\",\"lang\":\"ja\",\"timestamp_ms\":\"1488806543468\"}"), timeout: 1)
    expect(strs[1]).toEventually(equal("{\"delete\":{\"status\":{\"id\":1234,\"id_str\":\"1234\",\"user_id\":3,\"user_id_str\":\"3\"}}}"), timeout: 1)

  }
}
