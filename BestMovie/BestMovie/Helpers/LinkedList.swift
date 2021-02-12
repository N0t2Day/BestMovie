//
//  LinkedList.swift
//  DataStructures&Algorithms
//
//  Created by Artem Kedrov on 30/07/2019.
//  Copyright © 2019 Powercode. All rights reserved.
//

import Foundation

final class Node<T> {
  let value: T
  fileprivate(set) var next: Node?
  fileprivate(set) weak var previous: Node?

  init(value: T, next: Node? = nil, previous: Node? = nil) {
    self.value = value
    self.next = next
    self.previous = previous
  }
}

struct LinkedList<T> {
  private var uniqueReference = UniqueReference()
  fileprivate(set) var firstNode: Node<T>?

  fileprivate(set) var lastNode: Node<T>?

  var isEmpty: Bool { firstNode == nil }

  var first: WeakReference<Node<T>>? { firstNode?.weakReference }

  var last: WeakReference<Node<T>>? { lastNode?.weakReference }

  mutating func insertFirst(_ value: T) {
    copyIfNeeded()
    let node = Node(value: value, next: firstNode)
    firstNode?.previous = node
    firstNode = node
    if lastNode == nil, firstNode?.next == nil {
      lastNode = firstNode
    }
  }

  mutating func append(_ value: T) {
    copyIfNeeded()
    guard !isEmpty else {
      insertFirst(value)
      return
    }
    lastNode?.next = Node(value: value, previous: lastNode)
    lastNode = lastNode?.next
  }

  mutating func insert(_ value: T, after referenced: WeakReference<Node<T>>) {
    copyIfNeeded()
    guard lastNode !== referenced.node else {
      append(value)
      return
    }
    let oldNextNode = referenced.node?.next
    let newNode = Node(value: value, next: oldNextNode, previous: referenced.node)
    oldNextNode?.previous = newNode
    referenced.node?.next = newNode
  }

  @discardableResult
  mutating func removeFirst() -> T? {
    copyIfNeeded()
    defer {
      firstNode = firstNode?.next
      firstNode?.previous = nil
      if isEmpty {
        lastNode = nil
      }
    }
    return firstNode?.value
  }

  @discardableResult
  mutating func removeLast() -> T? {
    copyIfNeeded()
    guard firstNode?.next != nil else {
      removeFirst()
      return nil
    }
    defer {
      lastNode = lastNode?.previous
      lastNode?.next = nil

      if isEmpty {
        lastNode = nil
      }
    }
    return lastNode?.value
  }

  @discardableResult
  mutating func remove(after referenced: WeakReference<Node<T>>) -> T? {
    copyIfNeeded()
    defer {
      if referenced.node?.next === lastNode {
        lastNode = referenced.node
        lastNode?.next = nil
      }
      let newNext = referenced.node?.next?.next
      referenced.node?.next = newNext
      newNext?.previous = referenced.node
    }
    return referenced.node?.next?.value
  }
}

// MARK: - BidirectionalCollection extension

extension LinkedList: BidirectionalCollection {
  struct Index: Comparable {
    var node: Node<T>?
    static func == (lhs: LinkedList<T>.Index, rhs: LinkedList<T>.Index) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (left, right):
        return left === right
      }
    }

    static func < (lhs: LinkedList<T>.Index, rhs: LinkedList<T>.Index) -> Bool {
      guard lhs != rhs else { return false }
      let nodes = sequence(first: lhs.node) { $0?.next }
      return nodes.contains { $0 === rhs.node }
    }
  }

  var startIndex: LinkedList<T>.Index { Index(node: firstNode) }

  var endIndex: LinkedList<T>.Index { Index(node: lastNode) }

  func index(after i: LinkedList<T>.Index) -> LinkedList<T>.Index { Index(node: i.node?.next) }

  func index(before i: LinkedList<T>.Index) -> LinkedList<T>.Index { Index(node: i.node?.previous) }

  subscript(position: Index) -> T? { position.node?.value }
}

// MARK: - Copy-on-write реализация

extension LinkedList {
  private class UniqueReference {}
  private mutating func copyIfNeeded() {
    guard !isKnownUniquelyReferenced(&uniqueReference),
      var previous = firstNode else { return }
    firstNode = Node(value: previous.value)
    var current = firstNode
    while let next = previous.next {
      current?.next = Node(value: next.value, previous: current)
      current = current?.next
      previous = next
    }
    lastNode = current
    uniqueReference = UniqueReference()
  }
}

// MARK: - Debug only

extension LinkedList: CustomStringConvertible {
  var description: String {
    return firstNode?.description ?? "Empty list"
  }
}
