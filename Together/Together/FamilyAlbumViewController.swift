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

class FamilyAlbumViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {
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
    
  }
  
  
  @IBAction func leftButtonTapped(_ sender: UIButton) {
    albumView.swipe(.left)
  }
  
  @IBAction func rightButtonTapped(_ sender: UIButton) {
    albumView.swipe(.right)
  }
  
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
