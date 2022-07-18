// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let certNumberResultData = try? newJSONDecoder().decode(CERTNumberResultData.self, from: jsonData)

import Foundation

// MARK: - CertNumberResultData
struct CertNumberResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: CertNumberResult
}

// MARK: - CertNumberResult
struct CertNumberResult: Codable {
    let storeID: Int
    let jwt: String

    enum CodingKeys: String, CodingKey {
        case storeID = "storeId"
        case jwt
    }
}
