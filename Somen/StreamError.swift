//
//  StreamError.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/08.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation

enum StreamError: Swift.Error {
  case shutDown(reason: String)
  case duplicateStream(reason: String)
  case controlRequest(reason: String)
  case stall(reason: String)
  case normal(reason: String)
  case tokenRevoked(reason: String)
  case adminLogout(reason: String)
  case maxMessageLimit(reason: String)
  case streamException(reason: String)
  case brokerStall(reason: String)
  case shedLoad(reason: String)

  case unsupportedError(code: Int?, reason: String?, raw: [String: Any])

  var localizedDescription: String {
    switch self {
    case .shutDown(reason: let reason):
      return "The feed was shutdown (possibly a machine restart). Reason: \(reason)"
    case .duplicateStream(reason: let reason):
      return "The same endpoint was connected too many times. Reason: \(reason)"
    case .controlRequest(reason: let reason):
      return "Control streams was used to close a stream (applies to sitestreams). Reason: \(reason)"
    case .stall(reason: let reason):
      return "The client was reading too slowly and was disconnected by the server. Reason: \(reason)"
    case .normal(reason: let reason):
      return "The client appeared to have initiated a disconnect. Reason: \(reason)"
    case .tokenRevoked(reason: let reason):
      return "An oauth token was revoked for a user (applies to site and userstreams). Reason: \(reason)"
    case .adminLogout(reason: let reason):
      return "The same credentials were used to connect a new stream and the oldest was disconnected. Reason: \(reason)"
    case .maxMessageLimit(reason: let reason):
      return "The stream connected with a negative count parameter and was disconnected after all backfill was delivered. Reason: \(reason)"
    case .streamException(reason: let reason):
      return "An internal issue disconnected the stream. Reason: \(reason)"
    case .brokerStall(reason: let reason):
      return "An internal issue disconnected the stream. Reason: \(reason)"
    case .shedLoad(reason: let reason):
      return "The host the stream was connected to became overloaded and streams were disconnected to balance load. Reconnect as usual. Reason: \(reason)"
    case .unsupportedError(code: let code, reason: let reason, raw: _):
      return "Unsupported error received. Code: \(code), Reason: \(reason)"
    }
  }

  init(rawError: [String: Any]) {
    guard let code = rawError["code"] as? Int else {
      self = .unsupportedError(code: nil, reason: nil, raw: rawError)
      return
    }

    let reason = rawError["reason"] as? String ?? ""

    switch code {
    case 1:
      self = .shutDown(reason: reason)
    case 2:
      self = .duplicateStream(reason: reason)
    case 3:
      self = .controlRequest(reason: reason)
    case 4:
      self = .stall(reason: reason)
    case 5:
      self = .normal(reason: reason)
    case 6:
      self = .tokenRevoked(reason: reason)
    case 7:
      self = .adminLogout(reason: reason)
    case 9:
      self = .maxMessageLimit(reason: reason)
    case 10:
      self = .streamException(reason: reason)
    case 11:
      self = .brokerStall(reason: reason)
    case 12:
      self = .shedLoad(reason: reason)
    default:
      self = .unsupportedError(code: code, reason: reason, raw: rawError)
    }
  }
}
