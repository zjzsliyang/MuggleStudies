//
//  TestViewController.swift
//  Together
//
//  Created by Yang Li on 15/05/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
  var test = WishCard(positionX: 20, positionY: 100)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    super.view.addSubview(test)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
}
