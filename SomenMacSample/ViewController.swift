//
//  ViewController.swift
//  SomenMacSample
//
//  Created by Yuya Hirayama on 2017/03/05.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import Cocoa
import Somen
import RxSwift
import RxCocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


  var somen = Somen.init(consumerKey: "30RiR9yC9MWBR9BQqglprVg1R",
                         consumerSecret: "ByLCSDqPNFGAtrGA8VU71nrAkCUUfr26hjXG3kxaoVgEwrjLAC",
                         accessToken: "2338703922-RcdTl0IUlRvEhpyZIEdpGIT3znx1NK4IdtM9clK",
                         accessTokenSecret: "jxuzRUNF7gSqnqyRsgpAqLoTlcqivUiGRkx4QQPXyPiSv")
  var bag = DisposeBag.init()

  override func viewDidAppear() {
    super.viewDidAppear()

    somen.home().subscribe(onNext: { (event) in
      print(event)
    }, onError: { (error) in
      print(error)
    }, onCompleted: { 
      print("completed")
    }) { 
      print("disposed")
    }.addDisposableTo(bag)
  }


}

