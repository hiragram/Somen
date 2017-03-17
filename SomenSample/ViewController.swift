//
//  ViewController.swift
//  SomenSample
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import Somen
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  var somen = Somen.init(consumerKey: "30RiR9yC9MWBR9BQqglprVg1R",
                         consumerSecret: "ByLCSDqPNFGAtrGA8VU71nrAkCUUfr26hjXG3kxaoVgEwrjLAC",
                         accessToken: "2338703922-RcdTl0IUlRvEhpyZIEdpGIT3znx1NK4IdtM9clK",
                         accessTokenSecret: "jxuzRUNF7gSqnqyRsgpAqLoTlcqivUiGRkx4QQPXyPiSv")
  var bag = DisposeBag.init()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

  }

}

