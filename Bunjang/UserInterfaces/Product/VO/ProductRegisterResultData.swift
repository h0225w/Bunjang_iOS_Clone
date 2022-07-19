// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let productRegisterResultData = try? newJSONDecoder().decode(ProductRegisterResultData.self, from: jsonData)

import Foundation

// MARK: - ProductRegisterResultData
struct ProductRegisterResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    //let result: ProductRegisterResult
}

// MARK: - ProductRegisterResult
struct ProductRegisterResult: Codable {
    let productID: Int

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
    }
}
