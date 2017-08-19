//
//  RemoteImageView.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/19/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import UIKit
import Siesta

class RemoteImageView: UIImageView {
  static var imageCache: Service = Service()

  var placeholderImage: UIImage?

  var imageURL: URL? {
    get { return imageResource?.url }
    set { imageResource = RemoteImageView.imageCache.resource(absoluteURL: newValue) }
  }

  var imageResource: Resource? {
    willSet {
      imageResource?.removeObservers(ownedBy: self)
      imageResource?.cancelLoadIfUnobserved(afterDelay: 0.05)
    }

    didSet {
      imageResource?.loadIfNeeded()
      imageResource?.addObserver(owner: self) { [weak self] _ in
        self?.image = self?.imageResource?.typedContent(
          ifNone: self?.placeholderImage)
      }
    }
  }
}
