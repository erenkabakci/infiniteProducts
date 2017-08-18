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
  let view: BaseCollectionViewController
  let apiClient: ApiClient
  private lazy var products: [Product] = []
  private (set) var currentProductPage: Int = 0

  init(view: BaseCollectionViewController, apiClient: ApiClient = ApiClientImpl()) {
    self.view = view
    self.apiClient = apiClient

    view.onViewDidLoad = {
      apiClient.fetchProducts(forPage: self.currentProductPage)
        .addObserver(owner: self, closure: { [unowned self] (resource, resourceEvent) in
          if case .newData = resourceEvent {
            self.products = resource.typedContent() ?? []
          }
      }).loadIfNeeded()
    }
  }
}
