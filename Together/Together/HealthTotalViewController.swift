//
//  HealthTotalViewController.swift
//  Together
//
//  Created by Yang Li on 30/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit

class HealthTotalViewController: UIViewController {
  @IBOutlet weak var totalHealthChart: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    totalHealthChart.loadRequest(URLRequest(url: URL(string: "http://115.159.1.222:3000/h5/healthy/home/chart?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50Ijoic29uZ3dlaSIsInBhc3N3b3JkIjoiaGFoYWhhIiwiZGF0ZSI6IjE0OTM0NDE0NjUwMTciLCJpYXQiOjE0OTM0NDE0NjV9.YsDPI4MdLsnA-qWFSdxMSrvnyQPLtj4_zb5of5Jmgb8")!))
  }
}
