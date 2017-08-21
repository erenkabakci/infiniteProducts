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
  weak var view: (ViewLifecycleObservable & ProductListingPresentable)?
  let apiClient: ApiClient
  private var products: [Product] = [] {
    didSet {
      let productViewModels = products.flatMap { (product) -> ProductViewModel? in
        guard let thumbnailPath = product.thumbnailPath else {
          return nil
        }

        return ProductViewModel(name: product.name,
                                price: product.price,
                                imageUrl: thumbnailPath)
      }
      view?.updateDataSource(with: productViewModels)
    }
  }
  private var currentProductPage: Int = 0

  init(view: ViewLifecycleObservable & ProductListingPresentable,
       apiClient: ApiClient = ApiClientImpl()) {
    self.view = view
    self.apiClient = apiClient

    view.onViewDidLoad = {
      self.loadAdditionalProducts()
    }
  }

  func loadAdditionalProducts() {
    apiClient.fetchProducts(forPage: self.currentProductPage)
      .addObserver(owner: self, closure: { [weak self] (resource, resourceEvent) in
        if case .newData = resourceEvent {
          self?.products.append(contentsOf: resource.typedContent() ?? [])
          self?.currentProductPage += 1
        }
      }).load()
  }

  func lastVisibleIndexChanged(index: Int) {
    if index >= products.count * 2 / 3 {
      loadAdditionalProducts()
    }
  }
}
