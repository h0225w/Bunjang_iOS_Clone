//
//  ReviewService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/24.
//

import Foundation
import Alamofire

class ReviewService {
    // MARK: 후기 생성
    static func register(_ review: Review, completion: @escaping (ReviewFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/reviews")!
        
        let params = [
            "paymentId": review.paymentId,
            "rating": review.rating,
            "content": review.content
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ReviewFormResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 후기 수정
    static func edit(_ review: Review, reviewId: Int, completion: @escaping (ReviewFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/reviews/\(reviewId)")!
        
        let params = [
            "rating": review.rating,
            "content": review.content
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ReviewFormResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 후기 삭제
    static func delete(reviewId: Int, completion: @escaping (ReviewFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/reviews/\(reviewId)/status")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ReviewFormResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 후기 내역
    static func getReviews(storeId: Int, completion: @escaping (ReviewListResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/stores/\(storeId)/reviews")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
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
    
    // MARK: 상점 정보
    static func getReviewSingle(reviewId: Int, completion: @escaping (ReviewSingleResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/reviews/\(reviewId)")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ReviewSingleResultData.self) { response in
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
