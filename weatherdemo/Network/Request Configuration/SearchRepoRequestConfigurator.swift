//
//  SearchRepoRequestConfigurator.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//


import Foundation



struct SearchRepoRequestConfigurator: RequestConfigurator {
  
  private var searchString: String
  init(searchString: String) {
    self.searchString = searchString
  }
  
  var httpMethod: HTTPMethod {
    return .get
  }
  
  var httpProtocol: HTTPProtocol {
    return .https
  }
  
  var host: String {
    return "api.openweathermap.org"
  }
  
  var path: String {
    return "/data/2.5/forecast"
  }
  
  var unitOfMeasurement: MeasurementUnitType {
    get {
      return AppConstants.measurementUnitType //.metric
    }
  }
  
  var queryItems: [URLQueryItem]? {
    var queryItems = [URLQueryItem]()
    queryItems.append(URLQueryItem(name: "q", value: self.searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
    queryItems.append(URLQueryItem(name: "appid", value: self.apiKey.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
    queryItems.append(URLQueryItem(name: "units", value: self.unitOfMeasurement.rawValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
    return queryItems
  }
}

