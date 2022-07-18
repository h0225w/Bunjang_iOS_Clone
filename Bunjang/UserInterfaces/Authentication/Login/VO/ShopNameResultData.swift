// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shopNameResultData = try? newJSONDecoder().decode(ShopNameResultData.self, from: jsonData)

import Foundation

// MARK: - ShopNameResultData
struct ShopNameResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
