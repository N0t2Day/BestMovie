//
//  SpeakerRepository.swift
//  InvestForum
//
//  Created by Artem Kedrov on 14.01.2021.
//  Copyright © 2021 Powercode. All rights reserved.
//

import Foundation

enum ResponseState<T> {
  case success(T), failure(String)
}

class MovieRepository: Repository<Movie> {
  
  
  var page = 1
  var totalCount: Int?

  func refresh(completion: ((ResponseState<Void>)->())? = nil) {
    page = 1
    wipeAll()
    fetch(page: page, completion: completion)
  }
  
  func fetch(page: Int, completion: ((ResponseState<Void>)->())? = nil) {
    Network.performDecodableRequest(with: MovieApi.list(page: page), responseType: List<Movie>.self) {[weak self] result in
      switch result {
      case .success(let data):
        self?.totalCount = data.totalResults
        self?.append(data.results ?? [])
      case .emptyResponse: fatalError()
      case .failure(let error):
        self?.onMain { completion?(.failure(error.localizedDescription)) }
      }
    }
  }
  
  func fetchNext(for index: Int, completion: ((ResponseState<Void>)->())? = nil) {
    if count == index + 5,
       count < totalCount.zero {
      page += 1
      fetch(page: page, completion: completion)
    }
  }
}
