//
//  WeatherDetailsCell2.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import UIKit

final class WeatherDetailsCell2: UICollectionViewCell {
  
  @IBOutlet weak var containerView: UIView!
  
  @IBOutlet weak var lblCaption: UILabel!
  @IBOutlet weak var lblValue: UILabel!
  
  static let reusableIdentifier: String = "WeatherDetailsCell2"
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func awakeFromNib() {
    self.containerView?.layer.cornerRadius = 5.0
    
  }
  
}
