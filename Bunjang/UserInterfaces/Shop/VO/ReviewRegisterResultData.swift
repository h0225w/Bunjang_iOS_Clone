// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reviewRegisterResultData = try? newJSONDecoder().decode(ReviewRegisterResultData.self, from: jsonData)

import Foundation

// MARK: - ReviewRegisterResultData
struct ReviewRegisterResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
