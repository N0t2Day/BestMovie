//
//  UICollectionView.swift
//  Therapy
//
//  Created by Power Code on 23.07.2020.
//  Copyright © 2020 Powercode. All rights reserved.
//

import UIKit.UICollectionView

extension UICollectionView {
  func registerCellXib<T: UICollectionViewCell>(type: T.Type) {
    self.register(type.nib, forCellWithReuseIdentifier: type.identifier)
  }
  
  func registerCellClass<T: UICollectionViewCell>(type: T.Type) {
    self.register(type, forCellWithReuseIdentifier: type.identifier)
  }
  
  func registerSupplementaryXib<T: UICollectionReusableView>(type: T.Type) {
    self.register(type.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: type.identifier)
  }
  
  func dequeCell<T: UICollectionViewCell>(at indexPath: IndexPath) -> T {
    self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
  }
  
  func dequeSupplementary<T: UICollectionReusableView>(at indexPath: IndexPath) -> T {
    self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
  }
}
