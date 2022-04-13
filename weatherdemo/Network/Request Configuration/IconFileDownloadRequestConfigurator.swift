//
//  IconFileDownloadRequestConfigurator.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation

struct IconFileDownloadRequestConfigurator: RequestConfigurator {
  
  let iconFileName: String
  
  let httpMethod: HTTPMethod = .get
  
  let httpProtocol: HTTPProtocol = .http
  
  var host: String {
    get {
      return "openweathermap.org"
    }
  }
  
  let path: String
  
  init(_iconFileName: String) {
    self.iconFileName = _iconFileName
    self.path = "/img/wn/\(_iconFileName)@2x.png"
  }
  

}
