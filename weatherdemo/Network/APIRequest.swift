//
//  APIRequest.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//

import Foundation

public final class APIRequest<T: Decodable> {
  private let configurator: RequestConfigurator
  
  public init(configurator: RequestConfigurator) {
    self.configurator = configurator
  }
  
  public func makeRequest(_ completion: @escaping (T?, Error?) -> ()) {
    DispatchQueue.global(qos: .userInitiated).async {
      APIClient.dataTaskExecute(request: self.configurator.buildRequest()) { (data, response, error) in
        completion(self.makeModel(fromData: data), error)
      }
    }
  }
  
  private func makeModel<T: Decodable>(fromData data: Data?) -> T? {
    guard let jsonData = data else { return nil }
    let decoder = JSONDecoder()
    do {
      let model = try decoder.decode(T.self, from: jsonData)
      return model
      
    } catch {
      print(error)
      print(error.localizedDescription)
    }
    
    return nil
  }
}
