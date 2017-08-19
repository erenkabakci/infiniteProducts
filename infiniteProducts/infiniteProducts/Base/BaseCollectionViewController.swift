//
//  BaseViewRepresentable.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/18/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation
import UIKit

protocol ViewLifecycleObservable: class {
  var onViewDidLoad: (() -> Void)? { get set }
}

class BaseCollectionViewController: UICollectionViewController, ViewLifecycleObservable {
  // MARK: - ViewLifecycleObservable
  var onViewDidLoad: (() -> Void)?

  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    view.accessibilityIdentifier = String(describing: type(of: self))
    onViewDidLoad?()
  }
}
