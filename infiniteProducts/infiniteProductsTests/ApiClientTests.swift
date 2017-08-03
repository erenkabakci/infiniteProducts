//
//  ApiClientTests.swift
//  infiniteProductsTests
//
//  Created by Eren Kabakci on 8/3/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import XCTest
import Siesta
@testable import infiniteProducts

enum TestConstants {
  static let expectationTimeout: TimeInterval = 5
}

class ApiClientTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testProductsIntegration() {
    let apiClient = ApiClientImpl()
    let test = expectation(description: "Products endpoint integration has failed")

    apiClient.fetchProducts(forPage: 1).addObserver(owner: self) { (resource: Resource, resourceEvent: ResourceEvent) in
      if case .newData = resourceEvent {
        test.fulfill()
      }
    }.load()

    waitForExpectations(timeout: TestConstants.expectationTimeout) { (error) in
    }
  }
}
