// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addressListResultData = try? newJSONDecoder().decode(AddressListResultData.self, from: jsonData)

import Foundation

// MARK: - AddressListResultData
struct AddressListResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [AddressListResult]
}

// MARK: - AddressListResult
struct AddressListResult: Codable {
    let addressID: Int
    let name, phone, content, detail: String
    let defaultAddress: Bool

    enum CodingKeys: String, CodingKey {
        case addressID = "addressId"
        case name, phone, content, detail, defaultAddress
    }
}
