// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeProductsResultData = try? newJSONDecoder().decode(HomeProductsResultData.self, from: jsonData)

import Foundation

// MARK: - HomeProductsResultData
struct HomeProductsResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [HomeProductsResult]
}

// MARK: - HomeProductsResult
struct HomeProductsResult: Codable {
    let productId: Int
    let productImage: String
    let price: Int
    let name, date: String
    let safePayment: Bool
    let dibsCount: Int
    let status: String
}
