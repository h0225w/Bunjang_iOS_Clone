// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dibResultData = try? newJSONDecoder().decode(DibResultData.self, from: jsonData)

import Foundation

// MARK: - DibResultData
struct DibResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
