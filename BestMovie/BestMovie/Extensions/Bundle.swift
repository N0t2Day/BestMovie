//
//  Bundle.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation

extension Bundle {
  static func value(forInfo key: String) -> Any? {
    Bundle.main.object(forInfoDictionaryKey: key)
  }
}
