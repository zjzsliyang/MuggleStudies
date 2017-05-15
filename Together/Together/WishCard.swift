//
//  WishCard.swift
//  Together
//
//  Created by Yang Li on 15/05/2017.
//  Copyright © 2017 Yang Li. All rights reserved.
//

import UIKit

class WishCard: UITableViewCell {
  init(positionX: CGFloat, positionY: CGFloat) {
    super.init(style: .default, reuseIdentifier: "")
    
//    super.init(frame: CGRect(x: positionX, y: positionY, width: 324, height: 90))
    let wishCardBackground = UIImageView(frame: CGRect(x: positionX, y: positionY, width: 324, height: 90))
    print(positionX)
    print(positionY)
    wishCardBackground.image = UIImage(named: "wishCardBackground")
    
    let wishBottle = UIImageView(frame: CGRect(x: 14, y: 25, width: 34, height: 41))
    wishBottle.image = UIImage(named: "wishbottle-g0")
    wishCardBackground.addSubview(wishBottle)
    
    self.addSubview(wishCardBackground)
  }
  
  func updateWishCard() {
  
  }
  
  func detailWish() {
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
