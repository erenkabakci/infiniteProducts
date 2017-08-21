//
//  PresenterTests.swift
//  infiniteProductsTests
//
//  Created by Eren Kabakci on 8/20/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import XCTest
import Siesta
@testable import infiniteProducts

var service: Service!
var expectation1: XCTestExpectation!

class MockApiClient: ApiClient {
  func fetchProducts(forPage pageNumber: Int) -> Resource {
    return service.resource("/foo")
  }
}

class MockView: ViewLifecycleObservable, ProductListingPresentable {
  var onViewDidLoad: (() -> Void)?

  func updateDataSource(with products: [ProductViewModel]) {
    expectation1.fulfill()
  }
}

class PresenterTests: XCTestCase {
  var presenter: ProductListingPresenter!
  var networkStub: NetworkStub!

  override func setUp() {
    networkStub = NetworkStub()
    let bundle = Bundle(for: type(of: self))
    if let path = bundle.url(forResource: "dummy", withExtension: "json") {
      do {
        let jsonData = try Data(contentsOf: path)
        networkStub.responses["/foo"] = ResponseStub(data: jsonData)
      } catch {}
    }

    service = Service(baseURL: "http://test.ing", networking: networkStub)
    let goo = MockView()
    goo.onViewDidLoad = nil


    presenter = ProductListingPresenter(view: MockView(), apiClient: MockApiClient())
  }

  func testFoo() {
    expectation1 = expectation(description: "foo")
    let foo = MockApiClient()
    foo.fetchProducts(forPage: 1).addObserver(owner: self) { (resource, resourceEvent) in
      if case .newData = resourceEvent {
        let foo = resource.typedContent() ?? []
        expectation1.fulfill()
      }
    }.load()

//    presenter.loadAdditionalProducts()

    waitForExpectations(timeout: 5) { (error) in

    }
  }

  override func tearDown() {
    presenter = nil
    super.tearDown()
  }
}
