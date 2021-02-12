//
//  Optional.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation

extension Optional where Wrapped == Int {
  var zero: Int {
    self ?? .zero
  }
}

extension Optional where Wrapped == String {
  var empty: String {
    self ?? .init()
  }
}
