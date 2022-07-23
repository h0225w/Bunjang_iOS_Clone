// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addressSingleResultData = try? newJSONDecoder().decode(AddressSingleResultData.self, from: jsonData)

import Foundation

// MARK: - AddressSingleResultData
struct AddressSingleResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: AddressSingleResult
}

// MARK: - AddressSingleResult
struct AddressSingleResult: Codable {
    let addressID: Int
    let name, phone, content, detail: String
    let defaultAddress: Bool

    enum CodingKeys: String, CodingKey {
        case addressID = "addressId"
        case name, phone, content, detail, defaultAddress
    }
}
