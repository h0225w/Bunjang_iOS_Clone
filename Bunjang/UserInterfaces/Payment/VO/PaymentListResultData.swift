// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let paymentListResultData = try? newJSONDecoder().decode(PaymentListResultData.self, from: jsonData)

import Foundation

// MARK: - PaymentListResultData
struct PaymentListResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [PaymentListResult]
}

// MARK: - PaymentListResult
struct PaymentListResult: Codable {
    let paymentID: Int
    let purchase: Bool
    let paymentStatus: String
    let productImage: String
    let productName: String
    let price: Int
    let productStoreName, date: String

    enum CodingKeys: String, CodingKey {
        case paymentID = "paymentId"
        case purchase, paymentStatus, productImage, productName, price, productStoreName, date
    }
}
