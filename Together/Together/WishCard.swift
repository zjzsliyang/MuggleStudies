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
    wishCardBackground.image = UIImage(named: "wishCardBackground")
    
    let wishBottle = UIImageView(frame: CGRect(x: 14, y: 25, width: 34, height: 41))
    wishBottle.image = UIImage(named: "wishbottle-g0")
    wishCardBackground.addSubview(wishBottle)
    
    let wishLabel = UILabel(frame: CGRect(x: 74, y: 25, width: 42, height: 21))
    wishLabel.font = UIFont(name: "PingFang SC", size: 20)
    wishLabel.text = "你好"
    wishCardBackground.addSubview(wishLabel)
    
    let percentageImage = UIImageView(frame: CGRect(x: 74, y: 54, width: 18, height: 18))
    percentageImage.image = UIImage(named: "percentage-g0")
    wishCardBackground.addSubview(percentageImage)
    
    let dateLabel = UILabel(frame: CGRect(x: 105, y: 54, width: 60, height: 18))
    dateLabel.font = UIFont(name: "PingFang SC", size: 10)
    dateLabel.text = "2017.4.5 起"
    wishCardBackground.addSubview(dateLabel)
    
    
    let achieveImage = UIImageView(frame: CGRect(x: 220, y: 51, width: 19, height: 24))
    achieveImage.image = UIImage(named: "wishStar")
    wishCardBackground.addSubview(achieveImage)
    
    let achieveLabel = UILabel(frame: CGRect(x: 250, y: 54, width: 40, height: 18))
    achieveLabel.font = UIFont(name: "PingFang SC", size: 10)
    achieveLabel.text = "帮他实现"
    wishCardBackground.addSubview(achieveLabel)
    
    let wishMore = UIImageView(frame: CGRect(x: 40, y: 90, width: 276, height: 28))
    wishMore.image = UIImage(named: "wishMore-g")
    wishCardBackground.addSubview(wishMore)
    
    let progressLine = UIImageView(frame: CGRect(x: 30, y: 0, width: 242, height: 4))
    progressLine.image = UIImage(named: "progressLine-g")
    wishCardBackground.addSubview(progressLine)
    
    let wishCost = UILabel(frame: CGRect(x: 250, y: 25, width: 60, height: 21))
    wishCost.font = UIFont(name: "PingFang SC", size: 20)
    wishCost.textColor = UIColor(red: 217/255, green: 73/255, blue: 94/255, alpha: 1)
    wishCost.text = "$ 60k"
    wishCardBackground.addSubview(wishCost)
    
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
