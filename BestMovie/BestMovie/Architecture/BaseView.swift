//
//  BaseView.swift
//  Therapy
//
//  Created by Power Code on 21.07.2020.
//  Copyright © 2020 Power Code. All rights reserved.
//

import UIKit

protocol ModelListCell {
  associatedtype Model
  func setup(with model: Model)
}

protocol BaseView where Self: UIViewController {
  associatedtype PresenterType
  var presenter: PresenterType? { set get }
}

extension BaseView {

}
