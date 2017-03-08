# Somen

Somen provides a way to receive data from streaming API of Twitter with RxSwift observable.

__NOTICE: This library is still version 0 and under development. I do not recommend to use this library in production environment until version 1 release.__

## Example

1. Initialize Somen instance with your authorization tokens.

```swift
var somen = Somen.init(consumerKey: "YOUR_CONSUMER_KEY",
                         consumerSecret: "YOUR_CONSUMER_SECRET",
                         accessToken: "YOUR_ACCESS_TOKEN",
                         accessTokenSecret: "YOUR_ACCESS_TOKEN_SECRET")
```

2. Subscribe UserStream API

```swift
somen.home().subscribe(onNext: { (event) in
  switch event {
  case .newStatus(rawEvent: let e):
    // process new status event
    break
  case .favorite(rawEvent: let e):
    // process favorite event
    break
  default:
    break
  }
})
```

## Supported streams and events

Curently Somen supports [User streams](https://dev.twitter.com/streaming/userstreams). And following types of events are supported.

- newStatus
- deleteStatus
- deleteLocation
- limitNotice
- statusWithheld
- userWithheld
- stallWarning
- userUpdate
- friends
- directMessage
- block
- unblock
- favorite
- unfavorite
- follow
- unfollow
- listCreated
- listDestroyed
- listUpdated
- listMemberAdded
- listMemberRemoved
- listUserSubscribed
- listUserUnsubscribed
- quotedTweet

If unsupported event was received, the event is processed as `unsupportedEvent` and it has raw event dictionary as the associated value.

## Installation

Using Carthage:

Write as follows in Cartfile

```
github "hiragram/Somen"
```

then 

```sh
$ carthage update
```
