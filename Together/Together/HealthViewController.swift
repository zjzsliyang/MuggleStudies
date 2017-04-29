//
//  HealthViewController.swift
//  Together
//
//  Created by Yang Li on 28/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
import HealthKit

class HealthViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getHealthData()
  }
  
  @IBAction func backIndexView(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  
}
