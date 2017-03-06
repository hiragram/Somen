//
//  Event.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/05.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

// TODO: make sure to support all events

public enum Event {

  public typealias RawEvent = [String: Any]

  case newStatus(rawEvent: RawEvent)
  case deleteStatus(rawEvent: RawEvent)
  case deleteLocation(rawEvent: RawEvent)
  case limitNotice(rawEvent: RawEvent)
  case statusWithheld(rawEvent: RawEvent)
  case userWithheld(rawEvent: RawEvent)
  case stallWarning(rawEvent: RawEvent)
  case userUpdate(rawEvent: RawEvent)
  case friends(rawEvent: RawEvent)
  case directMessage(rawEvent: RawEvent)
  case block(rawEvent: RawEvent)
  case unblock(rawEvent: RawEvent)
  case favorite(rawEvent: RawEvent)
  case unfavorite(rawEvent: RawEvent)
  case follow(rawEvent: RawEvent)
  case unfollow(rawEvent: RawEvent)
  case listCreated(rawEvent: RawEvent)
  case listDestroyed(rawEvent: RawEvent)
  case listUpdated(rawEvent: RawEvent)
  case listMemberAdded(rawEvent: RawEvent)
  case listMemberRemoved(rawEvent: RawEvent)
  case listUserSubscribed(rawEvent: RawEvent)
  case listUserUnsubscribed(rawEvent: RawEvent)
  case quotedTweet(rawEvent: RawEvent)

  init?(rawEvent: RawEvent) {
    if rawEvent.keys.contains("retweet_count") && rawEvent.keys.contains("favorite_count") {
      self = .newStatus(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("delete") {
      self = .deleteStatus(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("scrub_geo") {
      self = .deleteLocation(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("limit") {
      self = .limitNotice(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("status_withheld") {
      self = .statusWithheld(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("user_withheld") {
      self = .userWithheld(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("warning") {
      self = .stallWarning(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "user_update" {
      self = .userUpdate(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("friends") || rawEvent.keys.contains("friends_str") {
      self = .friends(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "block" {
      self = .block(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "unblock" {
      self = .unblock(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "favorite" {
      self = .favorite(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "unfavorite" {
      self = .unfavorite(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "follow" {
      self = .follow(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "unfollow" {
      self = .unfollow(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_created" {
      self = .listCreated(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_destroyed" {
      self = .listDestroyed(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_updated" {
      self = .listUpdated(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_member_added" {
      self = .listMemberAdded(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_member_removed" {
      self = .listMemberRemoved(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_user_subscribed" {
      self = .listUserSubscribed(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "list_user_unsubscribed" {
      self = .listUserUnsubscribed(rawEvent: rawEvent)
    } else if rawEvent["event"] as? String == "quoted_tweet" {
      self = .quotedTweet(rawEvent: rawEvent)
    } else if rawEvent.keys.contains("recipient") && rawEvent.keys.contains("sender") {
      self = .directMessage(rawEvent: rawEvent)
    } else {
      return nil
    }
  }
}
