//
//  FamilyAlbumViewController.swift
//  Together
//
//  Created by Yang Li on 29/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    albumView.delegate = self
    albumView.dataSource = self
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
