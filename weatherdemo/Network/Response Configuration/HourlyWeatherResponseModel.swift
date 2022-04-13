//
//  HourlyWeatherResponseModel.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation


struct HourlyWeatherResponseItem: Decodable {  //PropertyLoopable {
  let cod: String
  let message: Int
  let cnt: Int  // == count
  let city: CityInfo
  let list: [HourlyDataItem]
  var jsonData: Data?
  
}

struct HourlyDataItem: Decodable {
  let dt: Double
  let visibility: Double
  let pop: Double
  let dt_txt: String
  let main: MainItem?
  let weather: [WeatherItem]
  let clouds: CloudsItem
  let wind: WindItem
  let sys: SysItem
  let rain: RainItem?
  let snow: SnowItem?
}

struct MainItem: Decodable {
  let temp: Double
  let feels_like: Double?
  let temp_min: Double?
  let temp_max: Double?
  let pressure: Int?
  let sea_level: Int?
  let grnd_level: Int?
  let humidity: Int?
  let temp_kf: Double?
  
}

struct WeatherItem: Decodable {
  let id: Int
  let main: String
  let description: String
  let icon: String
  
}

struct CloudsItem: Decodable {
  let all: Double // shows %
}

struct SysItem: Decodable {
  let pod: String
}

struct WindItem: Decodable {
  let speed: Double
  let deg: Int
  let gust: Double
  
}

struct RainItem: Decodable {
  let _3h: Double
  private enum CodingKeys: String, CodingKey {
    case _3h = "3h"
  }
}

struct SnowItem: Decodable {
  let snow: Double
}

struct CityInfo: Decodable {
  let id: Int
  let name: String
  let coord: Coord
  let country: String
  let population: Double
  let timezone: Double
  let sunrise: Double
  let sunset: Double
}


struct Coord: Decodable {
  let lat: Double
  let lon: Double
}

