//
//  HomeService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/20.
//

import Foundation
import Alamofire

class HomeService {
    // MARK: 홈 화면 상품 목록
    static func getProducts(completion: @escaping (HomeProductsResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/products/home")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: HomeProductsResultData.self) { response in
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
