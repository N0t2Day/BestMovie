//
//  BaseViewController.swift
//  Therapy
//
//  Created by Artem Kedrov on 14.09.2020.
//  Copyright © 2020 Powercode. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  var step: Flow { .noneFlow }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AppManager.flowLinkedList.append(step)
  }
  
  @objc override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    AppManager.flowLinkedList.removeLast()
  }
  
  func setup() {}
}

