// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shopProductsResultData = try? newJSONDecoder().decode(ShopProductsResultData.self, from: jsonData)

import Foundation

// MARK: - ShopProductsResultData
struct ShopProductsResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ShopProductsResult]?
}

// MARK: - ShopProductsResult
struct ShopProductsResult: Codable {
    let productID: Int
    let productImage: String
    let price: Int
    let name, date: String
    let safePayment: Bool
    let dibsCount: Int
    let status: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case productImage, price, name, date, safePayment, dibsCount, status
    }
}
