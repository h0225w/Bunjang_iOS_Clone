//
//  ReviewService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/24.
//

import Foundation
import Alamofire

class ReviewService {
    // MARK: 후기 내역
    static func getReviews(storeId: Int, completion: @escaping (ReviewListResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/stores/\(storeId)/reviews")!
        
        let request = Helper.makeRequest(url, method: "GET", dict: nil, token: token)
                                 
        AF.request(request)
            .responseDecodable(of: ReviewListResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print("error: \(error)")
                }
            }
    }
}
