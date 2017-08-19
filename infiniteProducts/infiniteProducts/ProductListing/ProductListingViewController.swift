//
//  ViewController.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/3/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import UIKit

protocol ProductListingPresentable {
  func updateDataSource() 
}

fileprivate enum Constants {
  static let cellReuseIdentifier = "productCell"
  static let itemsPerRow: CGFloat = 2
  static let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
  static let cellAccessoryHeight: CGFloat = 70.0
}

class ProductListingViewController: BaseCollectionViewController, ProductListingPresentable {
  private var presenter: ProductListingPresenter!

  override func viewDidLoad() {
    presenter = ProductListingPresenter(view: self)
    super.viewDidLoad()
  }

  func updateDataSource() {
    collectionView?.reloadData()
  }

  // MARK: - UICollectionViewDataSource protocol
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.products.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier,
                                                  for: indexPath)
    return cell
  }
}

extension ProductListingViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace - Constants.sectionInsets.left
    let widthPerItem = availableWidth / Constants.itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem + Constants.cellAccessoryHeight)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Constants.sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.sectionInsets.left
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Constants.sectionInsets.left
  }
}

