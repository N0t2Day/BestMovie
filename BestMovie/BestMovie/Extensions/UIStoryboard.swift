//
//  UIStoryboard.swift
//  Therapy
//
//  Created by Power Code on 22.07.2020.
//  Copyright © 2020 Power Code. All rights reserved.
//

import UIKit.UIStoryboard

extension UIStoryboard {
  func create<T: UIViewController>() -> T {
    self.instantiateViewController(withIdentifier: T.identifier) as! T
  }
}
