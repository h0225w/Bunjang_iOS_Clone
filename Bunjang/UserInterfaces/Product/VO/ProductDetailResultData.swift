// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productDetailResultData = try? newJSONDecoder().decode(ProdctDetailResultData.self, from: jsonData)

import Foundation

// MARK: - ProductDetailResultData
struct ProductDetailResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ProductDetailResult
}

// MARK: - ProductDetailResult
struct ProductDetailResult: Codable {
    let date, name: String
    let price: Int
    let category: String
    let tag: [String]
    let image: [String]
    let content: String
    let count: Int
    let safePayment, includeDeliveryCharge, used, exchange: Bool
    let dibsCount: Int
    let status: String
    let storeInformation: StoreInfo
    let dibs: Bool
    let follow: Bool
}

// MARK: - StoreInfo
struct StoreInfo: Codable {
    let storeID: Int
    let storeName: String
    let rating: Double
    let followerCount, productCount, reviewCount: Int
    let product: [StoreInfoProduct]?
    let review: [StoreInfoReview]?

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, rating, followerCount, productCount, reviewCount, product, review
    }
}

// MARK: - StoreInfoProduct
struct StoreInfoProduct: Codable {
    let productImage: String
    let name: String
    let price: Int
    let safePayment: Bool
}

// MARK: - StoreInfoReview
struct StoreInfoReview: Codable {
    let rating: Double
    let content: String
    let storeName: String
    let createdDate: String
}
