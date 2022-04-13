//
//  WeatherForecastListCell.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 12/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import UIKit

final class WeatherForecastListCell: UITableViewCell {
  
  @IBOutlet weak var lblToday: UILabel!
  
  @IBOutlet weak var lblTime: UILabel!
  
  @IBOutlet weak var lblMinTemperature: UILabel!
  
  @IBOutlet weak var lblMaxTemperature: UILabel!
  
  @IBOutlet weak var stackViewVerticle: UIStackView!
  
  @IBOutlet weak var viewCurrentHour: UIView!
  
  @IBOutlet weak var imagevIewWeatherTypeCode: UIImageView!
  
  
  static let reusableIdentifier: String =  "WeatherForecastListCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
