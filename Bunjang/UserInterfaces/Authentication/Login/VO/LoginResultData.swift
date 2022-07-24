// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginResultData = try? newJSONDecoder().decode(LoginResultData.self, from: jsonData)

import Foundation

// MARK: - LoginResultData
struct LoginResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: LoginResult
}

// MARK: - LoginResult
struct LoginResult: Codable {
    let code: String
}


