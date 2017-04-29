
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

class IndexViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var backgroundImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    let alertController = UIAlertController(title: "选择照片", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
    weak var weakself = self
    let alertActionLib = UIAlertAction(title: "相册", style: .default) { (_) -> Void in
      self.imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
      self.present(self.imagePickerController, animated: true, completion: nil)
    }
    let alertActionCamera = UIAlertAction(title: "相机", style: .default) { (_) in
      if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
        self.imagePickerController.sourceType = .camera
        self.present(weakself!.imagePickerController, animated: true, completion: nil)
      }
    }
    let alertActionCancel = UIAlertAction(title: "取消", style: .cancel) { (_) -> Void in
    }
    
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
    var livePhoto = PHLivePhoto()
    
    
    backgroundImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    backgroundImage.contentMode = .scaleAspectFill
    picker.dismiss(animated: true, completion: nil)
  }
}
