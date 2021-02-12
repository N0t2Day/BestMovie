//
//  UITableView.swift
//  BestMovie
//
//  Created by Artem Kedrov on 12.02.2021.
//

import UIKit

extension UITableView {
  func registerCellXib<T: UITableViewCell>(type: T.Type) {
    self.register(type.nib, forCellReuseIdentifier: type.identifier)
  }

  func registerHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) {
    self.register(type.nib, forHeaderFooterViewReuseIdentifier: type.identifier)
  }

  func dequeCell<T: UITableViewCell>(at indexPath: IndexPath) -> T {
    self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
  }

  func dequeHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
    self.dequeueReusableHeaderFooterView(withIdentifier: T.identifier) as! T
  }
}
