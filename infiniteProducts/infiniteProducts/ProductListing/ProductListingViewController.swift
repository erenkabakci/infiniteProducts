//
//  ViewController.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/3/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import UIKit

class ProductListingViewController: BaseCollectionViewController {
  private var presenter: ProductListingPresenter?
  override func viewDidLoad() {
    presenter = ProductListingPresenter(view: self)
    super.viewDidLoad()
  }
}

