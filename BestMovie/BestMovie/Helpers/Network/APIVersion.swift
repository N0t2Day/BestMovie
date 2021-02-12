//
//  APIVersion.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation

enum ApiVersion: String {
  case v3, v4
  
  var v: String {
    switch self {
    case .v3: return "/3"
    case .v4: return "/4"
    }
  }
  
  var apiKey: String {
    switch self {
    case .v3: return AppManager.stringFromPlist(for: .v3Api)
    case .v4: return AppManager.stringFromPlist(for: .v4Api)
    }
  }
}
