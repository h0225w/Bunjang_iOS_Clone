// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let shopDeleteResultData = try? newJSONDecoder().decode(ShopDeleteResultData.self, from: jsonData)

import Foundation

// MARK: - ShopDeleteResultData
struct ShopDeleteResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
