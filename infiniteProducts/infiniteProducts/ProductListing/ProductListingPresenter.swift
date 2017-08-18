//
//  ProductListingPresenter.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/18/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation
import UIKit

class ProductListingPresenter {
  let view: UIViewController
  let apiClient: ApiClient

  init(view: UIViewController, apiClient: ApiClient = ApiClientImpl()) {
    self.view = view
    self.apiClient = apiClient
  }
}
