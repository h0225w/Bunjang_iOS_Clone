//
//  ProductService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import Foundation
import Alamofire

class ProductService {
    // MARK: 상품 등록
    static func register(_ product: Product, completion: @escaping (ProductRegisterResultData) -> Void) {
        guard let storeId = UserDefaults.standard.string(forKey: "storeId"), let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/products")!
        
        let params = [
            "name": product.name,
            "price": product.price,
            "category": product.category,
            "content": product.content,
            "count": product.count,
            "safePayment": product.safePayment,
            "includeDeliveryCharge": product.deliveryCharge,
            "used": product.used,
            "exchange": product.exchange,
            "tag": product.tag,
            "image": product.images
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: ProductRegisterResultData.self) { response in
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
