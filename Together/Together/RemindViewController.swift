//
//  RemindViewController.swift
//  Together
//
//  Created by Yang Li on 30/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit

class RemindViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hidesBottomBarWhenPushed = true
    self.tabBarController?.tabBar.isHidden = true
    
    let alertController = UIAlertController(title: "该给妈妈打个电话了⚠️", message: "你已经十天没打啦", preferredStyle: .alert)
    let alertActionOk = UIAlertAction(title: "好", style: .default, handler: nil)
    //let alertActionLater = UIAlertAction(title: "稍等", style: .cancel, handler: nil)
    alertController.addAction(alertActionOk)
    //alertController.addAction(alertActionLater)
    present(alertController, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
