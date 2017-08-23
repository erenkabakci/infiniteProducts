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

private enum Constants {
  static let timeout: TimeInterval = 3.0
}

private var service: Service!
private var view = MockView()
private var apiClient = MockApiClient()
private var additionalLoadingExpectation: XCTestExpectation!

class MockApiClient: ApiClient {
  private (set) var currentPage: Int = 0
  func fetchProducts(forPage pageNumber: Int) -> Resource {
    currentPage = pageNumber
    return service.resource("/foo")
  }
}

class MockView: ViewLifecycleObservable, ProductListingPresentable {
  private (set) var verificationCount: Int = 0
  var onViewDidLoad: (() -> Void)?

  func updateDataSource(with products: [ProductViewModel]) {
    verificationCount += 1
    if view.verificationCount == 1 {
      additionalLoadingExpectation.fulfill()
    }
  }
}

class PresenterTests: XCTestCase {
  var presenter: ProductListingPresenter!
  var networkStub: NetworkStub!

  override func setUp() {
    prepareMockNetworkStack()
    presenter = ProductListingPresenter(view: view, apiClient: apiClient)
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

  func testPageNumberIncrement() {
    presenter.loadAdditionalProducts()
    XCTAssert(apiClient.currentPage == 0)
  }

  func testAdditionalProductTrigger() {
    additionalLoadingExpectation = expectation(description: "Additional product loading has failed")
    presenter.loadAdditionalProducts()
    waitForExpectations(timeout: Constants.timeout) { _ in}
  }
}
