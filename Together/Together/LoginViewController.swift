//
//  LoginViewController.swift
//  Together
//
//  Created by Yang Li on 28/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    username.attributedPlaceholder = NSAttributedString.init(string: "用户名", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
    password.attributedPlaceholder = NSAttributedString.init(string: "密码", attributes: [NSForegroundColorAttributeName:UIColor.lightGray])
    username.delegate = self
    password.delegate = self
    
    loginButton.layer.borderWidth = 1
    loginButton.layer.borderColor = UIColor.white.cgColor
    loginButton.layer.cornerRadius = 10
  }
  
  @IBAction func login(_ sender: UIButton) {
    let userParameters: Parameters = [
      "account": username.text!,
      "password": password.text!
    ]
    
    Alamofire.request("http://115.159.1.222:3000/api/login", method: .post, parameters: userParameters).responseString { (response) in
      let responseData = response.result.value!
      let responseJson = JSON(data: responseData.data(using: String.Encoding.utf8)!)
      print(responseJson)
    }
    
    let userDefault = UserDefaults.standard
    userDefault.set(true, forKey: "isLogin")
    self.dismiss(animated: true, completion: nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    let offset = textField.frame.origin.y + 136 - (self.view.frame.size.height - 216)
    let animationDuration : TimeInterval = 0.30
    UIView.beginAnimations("ResizeForKeyboard", context: nil)
    UIView.setAnimationDuration(animationDuration)
    
    if offset > 0 {
      self.view.frame = CGRect(x: 0.0, y: -offset, width: self.view.frame.size.width, height: self.view.frame.size.height)
      UIView.commitAnimations()
    }
  }
  
  @IBAction func touchDown(_ sender: Any) {
    self.view.endEditing(true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
  }
  
}
