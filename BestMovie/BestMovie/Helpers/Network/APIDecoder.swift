//
//  APIDecoder.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import Foundation

struct APIDecoder {
  private let decoder: JSONDecoder = .init()
  
  func decode<T: Codable>(data: Data, of type: T.Type) throws -> T {
    try decoder.decode(type, from: data)
  }
}
