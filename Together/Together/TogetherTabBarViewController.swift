//
//  TogetherTabBarViewController.swift
//  Together
//
//  Created by Yang Li on 30/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit

class TogetherTabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tabBar.isTranslucent = false
    self.tabBar.tintColor = UIColor(red: 207/255, green: 108/255, blue: 116/255, alpha: 1)
  }
}
