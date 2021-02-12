//
//  Endpoint.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation
import Alamofire

protocol Endpoint {
  var baseUrl: String { get }
  var version: ApiVersion { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: Parameters? { get }
  var encoding: ParameterEncoding { get }
  var headers: HTTPHeaders? { get }
}

extension Endpoint {
  var baseUrl: String { AppManager.stringFromPlist(for: .baseUrl) }
  var version: ApiVersion { .v3 }
  var path: String { baseUrl + version.v }
}
