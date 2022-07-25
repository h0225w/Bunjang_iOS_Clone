// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shopInfoResultData = try? newJSONDecoder().decode(ShopInfoResultData.self, from: jsonData)

import Foundation

// MARK: - ShopInfoResultData
struct ShopInfoResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ShopInfoResult
}

// MARK: - ShopInfoResult
struct ShopInfoResult: Codable {
    let storeID: Int
    let storeName: String
    let rating: Double
    let ratingCount, openDate, visitCount, productCount: Int
    let reviewCount, followingCount, followerCount, saleCount: Int
    let dibsCount: Int
    let follow: Bool

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case storeName, rating, ratingCount, openDate, visitCount, productCount, reviewCount, followingCount, followerCount, saleCount, dibsCount, follow
    }
}
