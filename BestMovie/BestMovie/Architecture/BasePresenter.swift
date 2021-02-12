//
//  BasePresenter.swift
//  Therapy
//
//  Created by Power Code on 21.07.2020.
//  Copyright © 2020 Power Code. All rights reserved.
//

import Foundation

class BasePresenter<ViewType: BaseView, RouterType: BaseRouter<ViewType>>: NSObject {
  unowned var view: ViewType
  var router: RouterType
  
  required init(view: ViewType, router: RouterType) {
    self.view = view
    self.router = router
    super.init()
  }
}
