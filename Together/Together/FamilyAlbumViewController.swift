//
//  FamilyAlbumViewController.swift
//  Together
//
//  Created by Yang Li on 29/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
import Alamofire
import Koloda
import PhotosUI
import MobileCoreServices

private var numberOfCards: Int = 5

class FamilyAlbumViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var albumView: KolodaView!
  
  fileprivate var dataSource: [UIImage] = {
    var array: [UIImage] = []
    for index in 0..<numberOfCards {
      array.append(UIImage(named: "Card_like_\(index + 1)")!)
    }
    
    return array
  }()
  
  @IBOutlet weak var albumTestView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    albumTestView.loadRequest(URLRequest(url: URL(string: "http://115.159.1.222:3000/h5/test")!))
//    albumView.delegate = self
//    albumView.dataSource = self
    self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
  }
  
  @IBAction func addPhoto(_ sender: UIButton) {
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
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let livePhoto: PHLivePhoto? = info[UIImagePickerControllerLivePhoto] as? PHLivePhoto
    if (livePhoto != nil) {
      print("todo")
    } else {
      let staticPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
      var data = UIImagePNGRepresentation(staticPhoto)!
      
      print(data)
      let documentPath: String = NSHomeDirectory().appending("Document")
      let fileManager = FileManager.default
      do {
        try fileManager.createDirectory(atPath: documentPath, withIntermediateDirectories: true, attributes: nil)
      } catch let error {
        print("fuck")
        print(error)
      }
      fileManager.createFile(atPath: documentPath + "/image.png", contents: data, attributes: nil)
      let filePath = documentPath + "/image.png"
      print("filePath" + String(filePath))
      
      Alamofire.upload(data, to: "http://10.0.1.8:3000/api/file").responseJSON(completionHandler: { (response) in
        print(response)
      })
      
//      Alamofire.upload(data, to: "http://10.0.1.8:3000/api/file", method: .post, headers: ["content-type":"multipart/form-data; boundary=\(boundary)"]).responseJSON(completionHandler: { (response) in
//        print(response)
//      })
//      Alamofire.upload(multipartFormData: { (multipartFormData) in
//        multipartFormData.append(data!, withName: "image")
//      }, usingThreshold: UInt64.init(), to: "http://10.0.1.8:3000/api/file", method: .post, headers: ["content-type":"multipart/form-data"], encodingCompletion: { (response) in
//        print(response)
//      })
    }
    picker.dismiss(animated: true, completion: nil)
  }
  
  private lazy var imagePickerController: UIImagePickerController = {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    return imagePickerController
  }()
  
  @IBAction func undoButtonTapped(_ sender: UIButton) {
    albumView.revertAction()
  }
  
  func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
    let position = albumView.currentCardIndex
    for i in 1...4 {
      dataSource.append(UIImage(named: "Card_like_\(i)")!)
    }
    albumView.insertCardAtIndexRange(position..<position + 4, animated: true)
  }
  
  func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
    print("goto//todo")
  }

  func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
    return dataSource.count
  }
  
  func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
    return .default
  }
  
  func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
    return UIImageView(image: dataSource[Int(index)])
  }
  
  func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
    return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
  }

}
