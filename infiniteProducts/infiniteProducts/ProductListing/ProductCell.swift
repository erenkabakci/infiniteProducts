//
//  ProductCell.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/19/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import UIKit
import Siesta

class ProductCell: UICollectionViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var imageView: RemoteImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    imageView.placeholderImage = UIImage(named: "placeholder")
  }
}

extension RemoteImageView {
}
