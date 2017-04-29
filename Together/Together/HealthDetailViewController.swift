//
//  HealthDetailViewController.swift
//  Together
//
//  Created by Yang Li on 29/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
import ContactsUI

class HealthDetailViewController: UIViewController, CNContactPickerDelegate {
  var phoneNumber: String?
  @IBOutlet weak var healthChart: UIWebView!

  override func viewDidLoad() {
    super.viewDidLoad()
    healthChart.loadRequest(URLRequest(url: URL(string: "http://115.159.1.222:3000/h5/healthy/my/chart?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50Ijoic29uZ3dlaSIsInBhc3N3b3JkIjoiaGFoYWhhIiwiZGF0ZSI6IjE0OTM0NDE0NjUwMTciLCJpYXQiOjE0OTM0NDE0NjV9.YsDPI4MdLsnA-qWFSdxMSrvnyQPLtj4_zb5of5Jmgb8")!))
  }
  @IBAction func getContact(_ sender: UIButton) {
    let contactPickerViewController = CNContactPickerViewController()
    contactPickerViewController.delegate = self
    present(contactPickerViewController, animated: true, completion: nil)
  }
  
  @IBAction func backHealthView(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
    for phone in contact.phoneNumbers {
      phoneNumber = phone.value.stringValue
      if phoneNumber != nil {
        UIApplication.shared.open(URL(string: "tel://" + phoneNumber!)!, options: [:], completionHandler: nil)
      }
    }
  }
  
}
