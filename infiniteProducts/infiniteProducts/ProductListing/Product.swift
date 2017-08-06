//
//  Product.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/6/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation
import Unbox

struct Product: Unboxable {
  let id: String
  let name: String
  let price: String
  let msrp: String?
  let sku: String?
  let enabledFrom: Date?
  let showMsrp: Bool?
  let msrpIndex: Double?
  let discount: Double?
  let thumbnailPath: URL?

  init(unboxer: Unboxer) throws {
    id = try unboxer.unbox(key: "id")
    name = try unboxer.unbox(key: "name")
    price = try unboxer.unbox(key: "price")
    msrp = unboxer.unbox(key: "msrp")
    sku = unboxer.unbox(key: "sku")

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    enabledFrom = unboxer.unbox(key: "enabled_from", formatter: dateFormatter)

    showMsrp = unboxer.unbox(key: "show_msrp")
    msrpIndex = unboxer.unbox(key: "show_msrp_index")
    discount = unboxer.unbox(key: "discount")
    thumbnailPath = unboxer.unbox(key: "thumbnail_path")
  }
}
