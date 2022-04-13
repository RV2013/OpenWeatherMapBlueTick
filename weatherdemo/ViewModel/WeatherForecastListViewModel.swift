//
//  WeatherForecastListViewModel.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 12/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation

final class WeatherForecastListViewModel  {
  
  var searchKeyword: String?
  private lazy var datamanager: DataManager =  DataManager()
  weak var weatherForecastListVCDelegate: WeatherForecastListVCDelegateProtocol?
  private var weatherForeCastResponseData: HourlyWeatherResponseItem?
  
  
  func fetchWeatherData(for cityName: String) {
    self.searchKeyword = cityName
    datamanager.searchReopsitory(searchString: cityName) {[weak self] (hourlyWeather: HourlyWeatherResponseItem?, error: Error?) in
      guard let weakSelf =  self,let hourlyWeather: HourlyWeatherResponseItem = hourlyWeather, error ==  nil else {
        if self?.weatherForecastListVCDelegate != nil {
          (self?.weatherForecastListVCDelegate)!.weatherDataReceived(with: nil, error: error)
        }
        return
      }
      
      // convert HourlyWeatherResponseItem --> WeatherForeCastListItem
      weakSelf.weatherForeCastResponseData = hourlyWeather
      var foreCatsListItems: [WeatherForeCastListItem] = []
      var setDayOfWeek: Set<String> = Set<String>()
      hourlyWeather.list.forEach { (item: HourlyDataItem) in
        guard let dateTimeOfObservation: Date = Date(timeIntervalSince1970: item.dt),
          let temp_min: Double = item.main?.temp_min, let temp_max: Double = item.main?.temp_max else{
            return
        }
        
        let hrText: String = dateTimeOfObservation.dayOfWeek()?.components(separatedBy: CharacterSet.init(charactersIn: ",")).last?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let hrTextAdjusted: String =  (hrText.count == 7) ? (hrText + "  ") : hrText
        let dayOfWeekText: String = dateTimeOfObservation.dayOfWeek()?.components(separatedBy: CharacterSet.init(charactersIn: ",")).first ?? ""
        if dayOfWeekText.isEmpty == false {
          setDayOfWeek.insert(dayOfWeekText)
        }
        let newItem =  WeatherForeCastListItem(dayOfObservation: dayOfWeekText,
                                               minTemperature: String(format: "%.1f\u{00B0}C", temp_min),
                                               maxTemperature: String(format: "%.1f\u{00B0}C", temp_max),
                                               isCurrentHour: false,
                                               weatherTypeImage: nil,
                                               hourOfObservationDay: hrTextAdjusted, cityName: self?.searchKeyword ?? "")
        foreCatsListItems.append(newItem)
      }
      
      
      if self?.weatherForecastListVCDelegate != nil {
        (self?.weatherForecastListVCDelegate)!.weatherDataReceived(with: foreCatsListItems, error: nil)
      }
      
    }
  }
  
  func selectItem(at index: Int) -> HourlyDataItem? {
    return self.weatherForeCastResponseData?.list[index]
  }
}





