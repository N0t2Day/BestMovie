//
//  ViewWithActivity.swift
//  Therapy
//
//  Created by Power Code on 10.08.2020.
//  Copyright © 2020 Powercode. All rights reserved.
//

import UIKit

class ViewWithActivity: UIView {
  var spinner = UIActivityIndicatorView(style: .large)

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }

  func setup() {
    backgroundColor = UIColor.black.withAlphaComponent(0.2)
    spinner.color = .white
    spinner.translatesAutoresizingMaskIntoConstraints = false
    spinner.startAnimating()
    addSubview(spinner)
    spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
}
