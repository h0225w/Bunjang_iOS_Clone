// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addressFormResultData = try? newJSONDecoder().decode(AddressFormResultData.self, from: jsonData)

import Foundation

// MARK: - AddressFormResultData
struct AddressFormResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
