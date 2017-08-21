//
//  NetworkProviderStub.swift
//  infiniteProductsTests
//
//  Created by Eren Kabakci on 8/21/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation
import Siesta

struct NetworkStub: NetworkingProvider {
  var responses: [String:ResponseStub] = [:]
  let dummyHeaders =
    [
      "A-LITTLE": "madness in the Spring",
      "Is-wholesome": "even for the King",
      "But-God-be": "with the Clown",
      "Who-ponders": "this tremendous scene",
      "This-whole": "experiment of green",
      "As-if-it": "were his own!",

      "X-Author": "Emily Dickinson"
  ]

  func startRequest(
    _ request: URLRequest,
    completion: @escaping RequestNetworkingCompletionCallback)
    -> RequestNetworking
  {
    let responseStub = responses[request.url!.path]
    let statusCode = (responseStub != nil) ? 200 : 404
    var headers = dummyHeaders
    headers["Content-Type"] = responseStub?.contentType
    let response = HTTPURLResponse(
      url: request.url!,
      statusCode: statusCode,
      httpVersion: "HTTP/1.1",
      headerFields: headers)

    completion(response, responseStub?.data, nil)
    return RequestStub()
  }
}

struct ResponseStub {
  let contentType: String = "application/octet-stream"
  let data: Data
}

struct RequestStub: RequestNetworking {
  func cancel() { }

  /// Returns raw data used for progress calculation.
  var transferMetrics: RequestTransferMetrics
  {
    return RequestTransferMetrics(
      requestBytesSent: 0,
      requestBytesTotal: nil,
      responseBytesReceived: 0,
      responseBytesTotal: nil)
  }
}
