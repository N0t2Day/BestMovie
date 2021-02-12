//
//  ActivityViewManager.swift
//  Therapy
//
//  Created by Power Code on 10.08.2020.
//  Copyright © 2020 Powercode. All rights reserved.
//

import UIKit

class ActivityViewManager {
  static let shared = ActivityViewManager()
  
  private init() {}  
  func showOn(_ view: UIView, for tag: Int) {
    let activity = ViewWithActivity(frame: .zero)
    activity.tag = tag
    view.addSubview(activity)
    activity.frame = view.bounds
  }
}
