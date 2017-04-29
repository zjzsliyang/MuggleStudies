//
//  ListAddNewViewController.swift
//  Together
//
//  Created by Yang Li on 28/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit

class ListAddNewViewController: UIViewController, UITextViewDelegate {
  @IBOutlet weak var listTextView: UITextView!
  @IBOutlet weak var alertLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    listTextView.text = "提醒你的家人..."
    listTextView.textColor = UIColor.lightGray
    listTextView.delegate = self
  }
  
  @IBAction func addAlertDate(_ sender: UIButton) {
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 370, width: 350, height: 300))
    datePicker.locale = Locale(identifier: "zh_CN")
    datePicker.addTarget(self, action: #selector(changeDate), for: UIControlEvents.valueChanged)
    self.view.addSubview(datePicker)
  }
  
  func changeDate(datePicker: UIDatePicker) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
    alertLabel.text = formatter.string(from: datePicker.date)
    print(formatter.string(from: datePicker.date))
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == UIColor.lightGray {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "提醒你的家人..."
      textView.textColor = UIColor.lightGray
    }
  }
  
  @IBAction func touchDown(_ sender: UIControl) {
    self.view.endEditing(true)
  }

  @IBAction func backListView(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
}
