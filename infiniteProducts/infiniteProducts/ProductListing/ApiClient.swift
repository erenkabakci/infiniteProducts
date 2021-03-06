//
//  ApiClient.swift
//  infiniteProducts
//
//  Created by Eren Kabakci on 8/3/17.
//  Copyright © 2017 Eren Kabakci. All rights reserved.
//

import Foundation
import Siesta
import Unbox

protocol ApiClient {
  func fetchProducts(forPage pageNumber:Int) -> Resource
}

class ApiClientImpl: Service {
  init() {
    super.init(baseURL: ServicePath.baseUrl)
    LogCategory.enabled = LogCategory.common

    configureTransformer(ServicePath.trendProducts) { (entity: Entity<[String: Any]>) -> [Product]? in
      return try unbox(dictionary: entity.content, atKeyPath: "trend_products.products")
    }
  }
}

fileprivate enum ServicePath {
  static let baseUrl = "https://test4.lesara.de/restapi/v1/"
  static let trendProducts = "trendproducts/"
}

fileprivate enum QueryConstants {
  static let appToken = ("app_token", "this_is_an_app_token")
  static let userToken = ("user_token",
                          "63a12a8116814a9574842515378c93c64846fc3d0858def78388be37e127cd17")
  static let storeId = ("store_id", 1)
  static let pageOverride = "page_override"
}

typealias ProductResourceDispatcher = ApiClientImpl
extension ProductResourceDispatcher: ApiClient {
  func fetchProducts(forPage pageNumber: Int) -> Resource {
    return resource(ServicePath.trendProducts)
      .withParam(QueryConstants.appToken.0, QueryConstants.appToken.1)
      .withParam(QueryConstants.userToken.0, QueryConstants.userToken.1)
      .withParam(QueryConstants.storeId.0, String(QueryConstants.storeId.1))
      .withParam(QueryConstants.pageOverride, String(pageNumber))
  }
}
