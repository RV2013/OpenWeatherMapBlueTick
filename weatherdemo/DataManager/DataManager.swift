//
//  DataManager.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation
import UIKit

final class DataManager {
  func searchReopsitory(searchString: String, _ callback: @escaping ((HourlyWeatherResponseItem?, Error?) -> ())) {
    APIRequest<HourlyWeatherResponseItem>.init(configurator: SearchRepoRequestConfigurator(searchString: searchString)).makeRequest { (model, error) in
      callback(model, error)
    }
  }
  
  func fetchImage(url: URL, callback: @escaping (UIImage?) -> Void) {
    let fileManager = FileManager.default
    
    guard var filePath = fileManager.urls(for: .cachesDirectory, in: .allDomainsMask).first else { return }
    filePath.appendPathComponent(url.pathComponents.last ?? "")
    
    if fileManager.fileExists(atPath: filePath.absoluteString) {
      callback(UIImage(contentsOfFile: filePath.absoluteString))
    } else {
      APIClient.downloadTaskExecute(request: URLRequest(url: url)) { (location) in
        do {
          let data = try Data(contentsOf: location)
          try data.write(to: filePath)
          try fileManager.removeItem(at: location)
          callback(UIImage(data: data))
        } catch {
          print(error.localizedDescription)
        }
      }
    }
  }
}
