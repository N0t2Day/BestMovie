//
//  PosterTableCell.swift
//  BestMovie
//
//  Created by Artem Kedrov on 12.02.2021.
//

import UIKit

protocol PosterCellRepresentable {
  var imagePath: String { get }
}

class PosterTableCell: UITableViewCell {
  
  @IBOutlet private weak var ivPosterImage: CacheImageView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    ivPosterImage.image = nil
  }
}

extension PosterTableCell: ModelListCell {
  func setup(with model: PosterCellRepresentable) {
    ivPosterImage.loadImage(urlString: model.imagePath)
  }
  
  func update(poster: UIImage?) {
    ivPosterImage.image = poster
  }
}
