// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let followResultData = try? newJSONDecoder().decode(FollowResultData.self, from: jsonData)

import Foundation

// MARK: - FollowResultData
struct FollowResultData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
