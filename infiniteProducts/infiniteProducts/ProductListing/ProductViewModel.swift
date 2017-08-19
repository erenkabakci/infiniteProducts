//
//  ProductViewModel.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/19/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation

struct ProductViewModel {
  let name: String
  let price: String
  let imageUrl: URL?

  init(name: String, price: String, imageUrl: URL) {
    self.name = name
    self.price = price
    self.imageUrl = URL(string: "https://daol3a7s7tps6.cloudfront.net/" + imageUrl.absoluteString)
  }
}
