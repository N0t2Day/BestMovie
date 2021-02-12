//
//  BMPresenter.swift
//  BestMovie
//
//  Created by Artem Kedrov on 12.02.2021.
//

import Foundation

protocol BMPresenter {
  func viewDidLoad()
  
  func sections() -> Int?
  func rows(in section: Int) -> Int?
  func setupTable(_ cell: PosterTableCell, at indexPath: IndexPath)
  func willDisplayTable(_ cell: PosterTableCell, at indexPath: IndexPath)
  func reload()
}

class BMPresenterImplementation: BasePresenter<BMView, BMRouter> {
  let repository = MovieRepository()
}

extension BMPresenterImplementation: BMPresenter {
  func viewDidLoad() {
    repository.refresh { [weak self] result in
      if case let ResponseState.failure(error) = result {
        self?.view.presentOKAlert(title: "Error", message: error)
      }
    }
    
    repository.dataDidChange = { [weak self] _ in
      self?.view.reloadList()
    }
  }
  
  func sections() -> Int? { 1 }
  
  func rows(in section: Int) -> Int? {
    repository.count
  }
  
  func setupTable(_ cell: PosterTableCell, at indexPath: IndexPath) {
    guard repository.count > indexPath.row else { return }
    let movie = repository.object(at: indexPath.row)
    cell.setup(with: movie)
  }
  
  func willDisplayTable(_ cell: PosterTableCell, at indexPath: IndexPath) {
    repository.fetchNext(for: indexPath.row) { [weak self] result in
      if case let ResponseState.failure(error) = result {
        self?.view.presentOKAlert(title: "Error", message: error)
      }
    }
  }
  
  func reload() {
    repository.refresh()
  }
}
