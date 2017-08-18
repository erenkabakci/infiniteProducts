//
//  ProductListingPresenter.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/18/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation
import UIKit
import Siesta

class ProductListingPresenter {
  let view: BaseCollectionViewController & ProductListingPresentable
  let apiClient: ApiClient
  private (set) var products: [Product] = [] {
    didSet {
      view.updateDataSource()
    }
  }
  private var currentProductPage: Int = 0

  init(view: BaseCollectionViewController & ProductListingPresentable, apiClient: ApiClient = ApiClientImpl()) {
    self.view = view
    self.apiClient = apiClient

    view.onViewDidLoad = {
      self.loadAdditionalProducts()
    }
  }

  func loadAdditionalProducts() {
    apiClient.fetchProducts(forPage: self.currentProductPage)
      .addObserver(owner: self, closure: { [unowned self] (resource, resourceEvent) in
        if case .newData = resourceEvent {
          self.products.append(contentsOf: resource.typedContent() ?? [])
          self.currentProductPage += 1
        }
      }).loadIfNeeded()
  }
}
