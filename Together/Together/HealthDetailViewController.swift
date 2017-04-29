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
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
