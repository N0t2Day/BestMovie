//
//  View.swift
//  Therapy
//
//  Created by Power Code on 21.07.2020.
//  Copyright © 2020 Power Code. All rights reserved.
//

import UIKit

extension UIView {
  class func fromNib<T: UIView>() -> T {
    return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
  
  static var identifier: String { String(describing: self) }
  static var nib: UINib { UINib(nibName: identifier, bundle: .main) }
  
  //MARK: - IBInspectable
  
  @IBInspectable
  var isMaskToBounds: Bool {
    get { self.layer.masksToBounds }
    set { self.layer.masksToBounds = newValue }
  }
  
  @IBInspectable
  var cornerRadius: CGFloat {
    get { return layer.cornerRadius }
    set { layer.cornerRadius = newValue }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      if let color = layer.borderColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.borderColor = color.cgColor
      } else {
        layer.borderColor = nil
      }
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get { return layer.shadowRadius }
    set { layer.shadowRadius = newValue }
  }
  
  @IBInspectable
  var shadowOpacity: Float {
    get { return layer.shadowOpacity }
    set { layer.shadowOpacity = newValue }
  }
  
  @IBInspectable
  var shadowOffset: CGSize {
    get { return layer.shadowOffset }
    set { layer.shadowOffset = newValue }
  }
  
  @IBInspectable
  var shadowColor: UIColor? {
    get {
      if let color = layer.shadowColor {
        return UIColor(cgColor: color)
      }
      return nil
    }
    set {
      if let color = newValue {
        layer.shadowColor = color.cgColor
      } else {
        layer.shadowColor = nil
      }
    }
  }
  
  func setCorner(topLeft: Bool, topRight: Bool, bottomLeft: Bool, bottomRight: Bool) {
    var corners = CACornerMask()
    if topLeft {
      corners = corners.union(.layerMinXMinYCorner)
    }
    if topRight {
      corners = corners.union(.layerMaxXMinYCorner)
    }
    if bottomLeft {
      corners = corners.union(.layerMinXMaxYCorner)
    }
    if bottomRight {
      corners = corners.union(.layerMaxXMaxYCorner)
    }
    layer.maskedCorners = corners
  }
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
  }
}

//MARK: - Constraints
extension UIView {
  func addAllSiddesConstraints(equalTo: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    topAnchor.constraint(equalTo: equalTo.topAnchor).isActive = true
    bottomAnchor.constraint(equalTo: equalTo.bottomAnchor).isActive = true
    leftAnchor.constraint(equalTo: equalTo.leftAnchor).isActive = true
    rightAnchor.constraint(equalTo: equalTo.rightAnchor).isActive = true
  }
}
