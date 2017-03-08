//
//  ObservableExtension.swift
//  Somen
//
//  Created by Yuya Hirayama on 2017/03/08.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType where E == String {
  func pollUntilNewline() -> Observable<String> {
    var nextEvent = ""

    return map({ (str) -> [String] in
      return str.components(separatedBy: "\r\n")
    })
      .scan([], accumulator: { (seed, added) -> [String] in
        guard !added.isEmpty else {
          return []
        }
        guard let first = added.first else {
          return []
        }
        guard first != "" else {
          return []
        }

        if added.count == 1 {
          nextEvent += added.first!
          return []
        }

        var completeJsons: [String] = []
        completeJsons.append(nextEvent + first)

        if let last = added.dropFirst().last {
          nextEvent = last
        }

        added.dropFirst().dropLast().forEach({ (jsonStr) in
          completeJsons.append(jsonStr)
        })

        return completeJsons
      })
      .flatMap({
        Observable.from($0)
      })
      .filter({ $0 != "" })
  }
}
