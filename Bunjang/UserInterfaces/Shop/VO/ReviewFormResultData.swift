// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reviewFormResultData = try? newJSONDecoder().decode(ReviewEditResultData.self, from: jsonData)

import Foundation

// MARK: - ReviewFormResultData
struct ReviewFormResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
