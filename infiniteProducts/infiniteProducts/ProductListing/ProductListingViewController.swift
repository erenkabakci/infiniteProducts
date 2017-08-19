//
//  ViewController.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/3/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import UIKit

protocol ProductListingPresentable {
  func updateDataSource(with products: [ProductViewModel])
}

fileprivate enum Constants {
  static let cellReuseIdentifier = "productCell"
  static let itemsPerRow: CGFloat = 2
  static let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
  static let cellAccessoryHeight: CGFloat = 70.0
}

class ProductListingViewController: BaseCollectionViewController, ProductListingPresentable {
  private var presenter: ProductListingPresenter!
  private var products: [ProductViewModel] = []

  override func viewDidLoad() {
    presenter = ProductListingPresenter(view: self)
    super.viewDidLoad()
    self.title = "Infinite Products"
  }

  func updateDataSource(with products: [ProductViewModel]) {
    self.products = products
    collectionView?.reloadData()
  }

  // MARK: - UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return products.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellReuseIdentifier, for: indexPath) as! ProductCell

    cell.nameLabel.text = products[indexPath.row].name
    cell.priceLabel.text = products[indexPath.row].price
    cell.imageView.imageURL = products[indexPath.row].imageUrl

    return cell
  }

  // MARK: - UIScrollViewDelegate
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    guard let lastVisibleCell = collectionView?.visibleCells.last,
      let lastVisibleIndexPath = collectionView?.indexPath(for: lastVisibleCell) else {
        return
    }
    presenter.lastVisibleIndexChanged(index: lastVisibleIndexPath.row)
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

