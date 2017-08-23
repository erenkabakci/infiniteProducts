//
//  PresenterTests.swift
//  infiniteProductsTests
//
//  Created by Eren Kabakci on 8/20/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import XCTest
import Siesta
import Unbox
@testable import infiniteProducts

private var service: Service!
private var productLoadExpectation: XCTestExpectation!

class MockApiClient: ApiClient {
  func fetchProducts(forPage pageNumber: Int) -> Resource {
    return service.resource("/foo")
  }
}

class MockView: ViewLifecycleObservable, ProductListingPresentable {
  var onViewDidLoad: (() -> Void)?

  func updateDataSource(with products: [ProductViewModel]) {
    productLoadExpectation.fulfill()
  }
}

class PresenterTests: XCTestCase {
  var presenter: ProductListingPresenter!
  var networkStub: NetworkStub!

  override func setUp() {
    prepareMockNetworkStack()
    presenter = ProductListingPresenter(view: MockView(), apiClient: MockApiClient())
  }

  override func tearDown() {
    presenter = nil
    super.tearDown()
  }

  private func prepareMockNetworkStack() {
    networkStub = NetworkStub()
    let bundle = Bundle(for: type(of: self))
    if let path = bundle.url(forResource: "products", withExtension: "json") {
      do {
        let jsonData = try Data(contentsOf: path)
        networkStub.responses["/foo"] = ResponseStub(data: jsonData)
      } catch {}
    }

    service = Service(baseURL: "http://test.ing", networking: networkStub)
    service.configureTransformer("/foo") { (entity: Entity<Data>) -> [Product]? in
      let rawData = try JSONSerialization.jsonObject(with: entity.content, options: []) as?
        [String: Any] ?? [:]
      return try unbox(dictionary: rawData, atKeyPath: "trend_products.products")
    }
  }

  func testFoo() {
    productLoadExpectation = expectation(description: "Additional product loading has failed")
    presenter.loadAdditionalProducts()

    waitForExpectations(timeout: 5) { (error) in

    }
  }
}
