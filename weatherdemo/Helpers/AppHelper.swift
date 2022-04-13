//
//  AppHelper.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 13/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation

enum MeasurementUnitType: String {
  case standard = "standard"
  case metric = "metric"
  case imperial = "imperial"
}

struct AppConstants {
  static let measurementUnitType: MeasurementUnitType = .metric
}


extension Date {
  func dayOfWeek() -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, h:mm a"
    return dateFormatter.string(from: self).capitalized
    // or use capitalized(with: locale) if you want
  }
}
