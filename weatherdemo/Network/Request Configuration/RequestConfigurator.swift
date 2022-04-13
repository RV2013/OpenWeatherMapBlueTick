//
//  RequestConfigurator.swift
//  weatherdemo
//
//  Created by Rachit Vyas on 11/04/22.
//  Copyright © 2022 rachitvyas. All rights reserved.
//


import Foundation

public enum HTTPMethod: String {
  case get, post, put, patch, delete
}

public enum HTTPProtocol: String {
  case http, https
}

/*
 A url request configuration protocol with default implementation.
 This protocol can be implemented to override the default values
 */

public protocol RequestConfigurator {
  
  var baseURL: URL? { get }
  var httpMethod: HTTPMethod { get }
  var httpProtocol: HTTPProtocol { get }
  var host: String { get }
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }
  var bodyParameters: [String: Any]? { get }
  var body: Data? { get }
  var headers: [String: String]? { get }
  
  var cachePolicy: URLRequest.CachePolicy { get }
  var timeoutInterval: TimeInterval { get }
  
  func buildRequest() -> URLRequest
}

extension RequestConfigurator {
  
  var apiKey: String {
    get { return "ff9d312509449f87deb38e5813f58108" }
  }
  
  var baseURL: URL? {
    var urlComponents = URLComponents(string: self.httpProtocol.rawValue + "://" + self.host + self.path)
    urlComponents?.queryItems = self.queryItems
    
    return urlComponents?.url
  }
  
  var host: String {
    return ""
  }
  
  var queryItems: [URLQueryItem]? {
    return nil
  }
  
  var bodyParameters: [String: Any]? {
    return nil
  }
  
  var body: Data? {
    return nil
  }
  
  var headers: [String: String]? {
    return nil
  }
  
  var cachePolicy: URLRequest.CachePolicy {
    return .reloadIgnoringLocalCacheData
  }
  
  var timeoutInterval: TimeInterval {
    return 60
  }
  
  func buildRequest() -> URLRequest {
    var request = URLRequest(url: self.baseURL!, cachePolicy: self.cachePolicy, timeoutInterval: self.timeoutInterval)
    request.httpMethod = self.httpMethod.rawValue
    request.allHTTPHeaderFields = self.headers
    return request
  }
}
