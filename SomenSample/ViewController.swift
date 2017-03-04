//
//  ViewController.swift
//  SomenSample
//
//  Created by Yuya Hirayama on 2017/03/04.
//  Copyright © 2017年 Yuya Hirayama. All rights reserved.
//

import UIKit
import Somen

class ViewController: UIViewController {

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
    Somen.init()
  }

}

