// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reviewSingleResultData = try? newJSONDecoder().decode(ReviewSingleResultData.self, from: jsonData)

import Foundation

// MARK: - ReviewSingleResultData
struct ReviewSingleResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ReviewSingleResult?
}

// MARK: - ReviewSingleResult
struct ReviewSingleResult: Codable {
    let rating: Double
    let content: String
}
