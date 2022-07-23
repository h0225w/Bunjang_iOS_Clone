// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let paymentResultData = try? newJSONDecoder().decode(PaymentResultData.self, from: jsonData)

import Foundation

// MARK: - PaymentResultData
struct PaymentResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
//    let result: PaymentResult
}

// MARK: - PaymentResult
struct PaymentResult: Codable {
    let paymentID: Int

    enum CodingKeys: String, CodingKey {
        case paymentID = "paymentId"
    }
}
