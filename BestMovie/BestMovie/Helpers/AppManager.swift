//
//  AppManager.swift
//  BestMovie
//
//  Created by Artem Kedrov on 10.02.2021.
//

import UIKit

enum Flow: Int {
  case noneFlow = 0
  case movieList
  case movieDetail
}

enum PlistNamespace: String {
  case v3Api = "v3ApiKey"
  case v4Api = "v4ApiKey"
  case baseUrl = "BaseUrl"
}

final class AppManager {
  static var flowLinkedList = LinkedList<Flow>()
  
  static var topController: UIViewController? {
    let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
    if var topController = keyWindow?.rootViewController {
      while let current = topController.presentedViewController {
        topController = current
      }
      return topController
    }
    return nil
  }
  
  private init() {}
}

extension AppManager {
  static func stringFromPlist(for key: PlistNamespace) -> String {
    (Bundle.value(forInfo: key.rawValue) as? String).empty
  }
}


