//
//  PaymentService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import Foundation
import Alamofire

class PaymentService {
    // MARK: 결제 생성
    static func register(_ payment: Payment, completion: @escaping (PaymentResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/payments")!
        
        let params = [
            "productId": payment.productId,
            "addressId": payment.addressId,
            "parcel": payment.parcel,
            "request": payment.request,
            "paymentMethod": payment.paymentMethod,
            "usingPoint": payment.usingPoint
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: PaymentResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 거래완료된 결제 내역
    static func getPayments(_ type: String = "all", completion: @escaping (PaymentListResultData) -> Void) {
        guard let storeId = UserDefaults.standard.string(forKey: "storeId"), let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/stores/\(storeId)/payments?type=\(type)")!
        
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: PaymentListResultData
                                .self) { response in
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
