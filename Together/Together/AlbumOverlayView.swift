//
//  AlbumOverlayView.swift
//  Together
//
//  Created by Yang Li on 30/04/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class AlbumOverlayView: OverlayView {
  @IBOutlet lazy var overlayImageView: UIImageView! = {
    [unowned self] in
    
    var imageView = UIImageView(frame: self.bounds)
    self.addSubview(imageView)
    
    return imageView
    }()
  
  override var overlayState: SwipeResultDirection? {
    didSet {
      switch overlayState {
      case .left? :
        overlayImageView.image = UIImage(named: overlayLeftImageName)
      case .right? :
        overlayImageView.image = UIImage(named: overlayRightImageName)
      default:
        overlayImageView.image = nil
      }
    }
  }
}
