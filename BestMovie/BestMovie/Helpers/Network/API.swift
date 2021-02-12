//
//  API.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation
import Alamofire

enum MovieApi: Endpoint {
  
  case list(page: Int)
  
  var method: HTTPMethod {
    switch self {
    case .list: return .get
    }
  }
  var parameters: Parameters? {
    var param:[String: Any] = [
      "language": "en-US",
      "api_key": self.version.apiKey
    ]
    switch self {
    case .list(page: let page):
      param["page"] = page
      return param
    }
  }
  var encoding: ParameterEncoding {
    switch self {
    case .list: return URLEncoding.default
    }
  }
  var headers: HTTPHeaders? {
    ["api_key" : version.apiKey]
  }
  
  var path: String {
    switch self {
    case .list: return baseUrl + version.v + "/movie/popular"
    }
  }
}

