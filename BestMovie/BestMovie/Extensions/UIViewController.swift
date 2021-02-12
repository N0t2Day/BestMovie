//
//  UIViewController.swift
//  Therapy
//
//  Created by Power Code on 04.08.2020.
//  Copyright © 2020 Powercode. All rights reserved.
//

import UIKit

extension UIViewController {
  static var identifier: String { String(describing: self) }
  
  func presentAlert(title: String?, message: String?, style: UIAlertController.Style, onOk: (() -> ())? = nil, onCancel: (() -> ())? = nil) {
    guard let topController = AppManager.topController else { return }
    let aler = UIAlertController(title: title, message: message, preferredStyle: style)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in onOk?() }
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in onCancel?() }
    aler.addAction(okAction)
    aler.addAction(cancelAction)
    topController.present(aler, animated: true, completion: nil)
  }

  func presentOKAlert(title: String?, message: String?, completion: (() -> ())? = nil) {
    guard let topController = AppManager.topController else { return }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in completion?() }
    alert.addAction(okAction)
    topController.present(alert, animated: true, completion: nil)
  }
  
  func presentOkError(_ error: Error, detailText: String? = nil) {
    guard let topController = AppManager.topController else { return }
    topController.presentOKAlert(title: "Error \((error as NSError).code)", message: error.localizedDescription + detailText.empty)
  }

  func showInfoError(title: String?, message: String?, hideAfter delay: TimeInterval, action: (() -> ())?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    present(alert, animated: true, completion: {
      DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
        self?.dismiss(animated: true, completion: action)
      }
    })
  }
}

extension UIViewController {
  
  class var board: UIStoryboard {
    UIStoryboard(name: self.identifier, bundle: .main)
  }
  
  class func createRootView<T: UIViewController>() -> T {
    UIStoryboard(name: T.identifier, bundle: .main).instantiateViewController(withIdentifier: T.identifier) as! T
  }
  
  static let activityViewTag = 999

  func showActivity() {
    ActivityViewManager.shared.showOn(self.view, for: Self.activityViewTag)
  }

  func hideActivity() {
    let activityView = self.view.subviews.first { $0.tag == Self.activityViewTag }
    activityView?.removeFromSuperview()
  }
}
