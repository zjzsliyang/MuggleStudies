
//
//  IndexViewController.swift
//  Together
//
//  Created by Yang Li on 28/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
import PhotosUI
import MobileCoreServices
import UserNotifications

class IndexViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var backgroundView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
/*    Notifications */
    
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
//      if error != nil {
//        print(error)
//      }
//    }
//    
//    let content = UNMutableNotificationContent()
//    content.title = "Time Funck"
//    content.subtitle = "subtitle"
//    content.body = "body"
//    
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: true)
//    
//    let request = UNNotificationRequest(identifier: "cn.edu.tongji.Together.fisrtNotificationIndentifier", content: content, trigger: trigger)
//    UNUserNotificationCenter.current().add(request) { (error) in
//      if error == nil {
//        print("hello")
//      }
//    }
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    let userDefault = UserDefaults.standard
    guard userDefault.bool(forKey: "isLogin") else {
      self.performSegue(withIdentifier: "login", sender: nil)
      return
    }
  }
  
  @IBAction func chosePhoto(_ sender: UIButton) {
    let alertController = UIAlertController(title: "选择照片", message: nil, preferredStyle: .actionSheet)
    let alertActionLib = UIAlertAction(title: "相册", style: .default) { (_) in
      if #available(iOS 9.1, *) {
        self.imagePickerController.mediaTypes = [kUTTypeLivePhoto as String, kUTTypeImage as String]
      } else {
        self.imagePickerController.mediaTypes = [kUTTypeImage as String]
      }
      self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
      self.present(self.imagePickerController, animated: true, completion: nil)
    }
    let alertActionCamera = UIAlertAction(title: "相机", style: .default) { (_) in
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        self.imagePickerController.sourceType = .camera
        self.present(self.imagePickerController, animated: true, completion: nil)
      }
    }
    let alertActionCancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    
    alertController.addAction(alertActionLib)
    alertController.addAction(alertActionCamera)
    alertController.addAction(alertActionCancel)
    self.present(alertController, animated: true, completion: nil)
  }
  
  private lazy var imagePickerController: UIImagePickerController = {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    return imagePickerController
  }()
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let livePhoto: PHLivePhoto? = info[UIImagePickerControllerLivePhoto] as? PHLivePhoto
    if (livePhoto != nil) {
      let livePhotoView = PHLivePhotoView(frame: backgroundView.frame)
      livePhotoView.livePhoto = info[UIImagePickerControllerLivePhoto] as? PHLivePhoto
      livePhotoView.startPlayback(with: .full)
      livePhotoView.contentMode = .scaleAspectFill
      backgroundView.addSubview(livePhotoView)
    } else {
      let staticPhotoView = UIImageView(frame: backgroundView.frame)
      staticPhotoView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
      staticPhotoView.contentMode = .scaleAspectFill
      backgroundView.addSubview(staticPhotoView)
    }
    picker.dismiss(animated: true, completion: nil)
  }
}
