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
      "username": username.text!,
      "password": password.text!
    ]
    
    Alamofire.request("", method: .post, parameters: userParameters).responseString { (response) in
      let responseData = response.result.value!
      let responseJson = JSON(data: responseData.data(using: String.Encoding.utf8)!)
      
      guard responseJson["info"]["number"].stringValue == (ERROR_INFO["SUCCESS"]?["number"])! else {
        let alertView = UIAlertController(title: "登录失败", message: "", preferredStyle: .alert)
        switch responseJson["info"]["number"].stringValue {
        case (ERROR_INFO["REQUEST_ERR"]?["number"])!:
          alertView.message = "请输入用户名或密码"
        case (ERROR_INFO["PASSWD_ERR"]?["number"])!:
          alertView.message = "用户名或密码错误，请重新输入"
        case (ERROR_INFO["USER_ERR"]?["number"])!:
          alertView.message = "不存在此用户"
        default:
          alertView.message = "未知错误，错误代码：" + responseJson["number"].stringValue
          print("其他错误：" + responseJson["value"].stringValue)
          print("错误代码：" + responseJson["number"].stringValue)
        }
        alertView.addAction(UIAlertAction(title: "好", style: .default, handler: { (action) in
          self.dismiss(animated: true, completion: nil)
        }))
        return
      }
      
      let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
      hud.label.text = "登录中..."
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
