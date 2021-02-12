//
//  WeakReference.swift
//  DataStructures&Algorithms
//
//  Created by Dmitry Melnikov on 31/07/2019.
//  Copyright © 2019 Dmitry Melnikov. All rights reserved.
//

import Foundation

protocol WeakReferencePotocol: AnyObject {
    associatedtype T
    var weakReference: WeakReference<Node<T>> { get }
}

final class WeakReference<T: AnyObject> {
    private(set) weak var node: T?
    
    init(node: T?) {
        self.node = node
    }
}

extension Node: WeakReferencePotocol {
    var weakReference: WeakReference<Node<T>> {
        return WeakReference(node: self)
    }
}

extension Node: CustomStringConvertible {
    
    var description: String {
        guard let next = next else { return "\(value)"}
        return "\(value) -> \(next.description)"
    }
}
