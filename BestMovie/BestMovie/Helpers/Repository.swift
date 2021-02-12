//
//  Repository.swift
//  InvestForum
//
//  Created by Artem Kedrov on 14.01.2021.
//  Copyright © 2021 Powercode. All rights reserved.
//

import Foundation

typealias RefeshCallback = (()->())

class Repository<T> {
  
  enum DataUpdateAction {
    case insert(Int)
    case delete(Int)
    case new
  }
  
  var dataWillChange: ((DataUpdateAction)->())?
  var dataDidChange: ((DataUpdateAction)->())?
  
  var count: Int { self.value.count }
  
  var isEmpty: Bool { self.value.isEmpty }
  
  var last: Model? { self.value.last }
  var first: Model? { self.value.first }
  
  typealias Model = T
  
  private var value: [Model]
  
  required init(default data: [Model] = []) {
    self.value = data
  }
  
  func object(at index: Int) -> Model {
    self.value[index]
  }
  
  func insert(_ object: Model, at index: Int) {
    dataWillChange?(.insert(index))
    self.value.insert(object, at: index)
    dataDidChange?(.insert(index))
  }
  
  func insert(_ object: Model) {
    dataWillChange?(.insert(self.value.count))
    self.value.append(object)
    dataDidChange?(.insert(self.value.count))
  }
  
  func append(_ objects: [Model]) {
    dataWillChange?(.insert(self.value.count))
    self.value.append(contentsOf: objects)
    dataDidChange?(.insert(self.value.count))
  }
  
  func delete(at index: Int) {
    guard self.value.count > index else { return }
    dataWillChange?(.delete(index))
    self.value.remove(at: index)
    dataDidChange?(.delete(index))
  }
  
  func wipeAll() {
    dataWillChange?(.new)
    self.value.removeAll()
    dataDidChange?(.new)
  }
  
  func onMain(block: @escaping ()->()) {
    DispatchQueue.main.async { block() }
  }
}
