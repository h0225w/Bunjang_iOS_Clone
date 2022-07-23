//
//  AddressService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import Foundation
import Alamofire

class AddressService {
    // MARK: 결제 등록
    static func register(_ address: Address, completion: @escaping (AddressFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/address")!
        
        let params = [
            "name": address.name,
            "phone": address.phone,
            "content": address.phone,
            "detail": address.detail,
            "defaultAddress": address.defaultAddress
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AddressFormResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
}
