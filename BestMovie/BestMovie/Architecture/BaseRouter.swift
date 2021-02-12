//
//  BaseRouter.swift
//  MyPsychologist
//
//  Created by Konstantin Shendenkov on 18.06.2018.
//  Copyright © 2018 NATIFE. All rights reserved.
//

import Foundation

class BaseRouter<ViewType: BaseView> {
  unowned var view: ViewType
  
  required init(view: ViewType) {
    self.view = view
  }
  
}

