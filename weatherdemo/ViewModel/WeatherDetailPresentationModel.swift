//
//  WeatherDetailPresentationModel.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 12/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation

enum PhysicalQuantityType {
  case temperature, pressure, percentage, speed, windDirection, visibility, pop, rain, snow
  case none
  
  func getMeasurementUnitFor(measurementType: MeasurementUnitType) -> String {
    let tupeToCheck : (PhysicalQuantityType, MeasurementUnitType) = (self, measurementType)
    switch tupeToCheck {
      case (.temperature, .metric):
        return "\u{00B0} C"
      case (.percentage, _), (.pop, _):
        return "%"
      case (.pressure, .metric):
        return "hPa"
      case (.speed, .metric):
        return "m/s"
      case (.windDirection, _):
        return "\u{00B0} deg."
      case (.visibility, _):
        return "mtrs"
      case (.rain, _), (.snow, _):
        return "mm"
      default:
        return ""
    }
  }
}


struct WeatherForecatsDetailPresentationModel {
  
  var detailsData: [String: [PresentatbleWeatherItem]] = [:]
  private let model: HourlyDataItem
  
  init(with model: HourlyDataItem) {
    self.model =  model
  }
  
  mutating func prepareDetails() {
    var presentationModels: [PresentatbleWeatherItem] = []
    let visibilityModel = PresentatbleWeatherItem(caption: "visibility".localizedUppercase, value: getValue(property: model.visibility, physicalQuantityType: .visibility), childs: nil)
    let popModel = PresentatbleWeatherItem(caption: "pop".localizedUppercase, value: getValue(property: model.pop, physicalQuantityType: .pop), childs: nil)
    let windItemSpeedModel = PresentatbleWeatherItem(caption: "Wind Speed".localizedUppercase, value: getValue(property: model.wind.speed, physicalQuantityType: .speed), childs: nil)
    let windItemDegModel = PresentatbleWeatherItem(caption: "Wind Direction".localizedUppercase, value: getValue(property: model.wind.deg, physicalQuantityType: .windDirection), childs: nil)
    let windItemGustModel = PresentatbleWeatherItem(caption: "Wind Gust".localizedUppercase, value: getValue(property: model.wind.gust, physicalQuantityType: .speed), childs: nil)
    
    presentationModels.append(visibilityModel)
    presentationModels.append(popModel)
    presentationModels.append(windItemSpeedModel)
    presentationModels.append(windItemDegModel)
    presentationModels.append(windItemGustModel)
    
    detailsData["main"] = presentationModels
  }
  
  private func getValue<T>(property: T, physicalQuantityType: PhysicalQuantityType  ) -> String {
    switch property.self  {
      case is Double where physicalQuantityType == .temperature:
        return String.init(format: "%.1f %@", property as! CVarArg, physicalQuantityType.getMeasurementUnitFor( measurementType: MeasurementUnitType.metric))
      case is Double where physicalQuantityType != .temperature:
        return String.init(format: "%.2f %@", property as! CVarArg, physicalQuantityType.getMeasurementUnitFor( measurementType: MeasurementUnitType.metric))
      case is Int :
        return String.init(format: "%d %@", property as! CVarArg, physicalQuantityType.getMeasurementUnitFor( measurementType: MeasurementUnitType.metric))
      default:
        return "not allowed"
    }
  }
}



