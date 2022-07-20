//
//  ShopService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import Foundation
import Alamofire

class ShopService {
    // MARK: 상점 정보
    static func getShopInfo(storeId: Int, completion: @escaping (ShopInfoResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/stores/\(storeId)")!
        
        let request = Helper.makeRequest(url, method: "GET", dict: nil, token: token)
                                 
        AF.request(request)
            .responseDecodable(of: ShopInfoResultData.self) { response in
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
