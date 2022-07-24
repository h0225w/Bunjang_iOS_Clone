// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reviewListResultData = try? newJSONDecoder().decode(ReviewListResultData.self, from: jsonData)

import Foundation

// MARK: - ReviewListResultData
struct ReviewListResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [ReviewListResult]
}

// MARK: - ReviewListResult
struct ReviewListResult: Codable {
    let reviewID: Int
    let storeName: String
    let rating: Int
    let content, date: String
    let safePayment: Bool
    let productID: Int
    let productName: String

    enum CodingKeys: String, CodingKey {
        case reviewID = "reviewId"
        case storeName, rating, content, date, safePayment
        case productID = "productId"
        case productName
    }
}
