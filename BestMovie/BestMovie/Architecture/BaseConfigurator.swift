//
//  BaseConfigurator.swift
//  Therapy
//
//  Created by Power Code on 21.07.2020.
//  Copyright © 2020 Power Code. All rights reserved.
//

import Foundation

class BaseConfigurator<ViewType: BaseView, RouterType: BaseRouter<ViewType>,
                                        PresenterType: BasePresenter<ViewType, RouterType>> {
  
  @discardableResult
  func configure(_ view: ViewType) -> PresenterType {
    let router = RouterType(view: view)
    let presenter = PresenterType(view: view, router: router)
    
    view.presenter = presenter as? ViewType.PresenterType
    
    return presenter
  }
}
