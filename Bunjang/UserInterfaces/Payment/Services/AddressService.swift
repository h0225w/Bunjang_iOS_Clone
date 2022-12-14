//
//  AddressService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import Foundation
import Alamofire

class AddressService {
    // MARK: 주소 추가
    static func register(_ address: Address, completion: @escaping (AddressFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/address")!
        
        let params = [
            "name": address.name,
            "phone": address.phone,
            "content": address.content,
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
    
    // MARK: 주소 수정
    static func edit(_ address: Address, addressId: Int, completion: @escaping (AddressFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/address/\(addressId)")!
        
        let params = [
            "name": address.name,
            "phone": address.phone,
            "content": address.content,
            "detail": address.detail,
            "defaultAddress": address.defaultAddress
        ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers)
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
    
    // MARK: 주소 삭제
    static func delete(addressId: Int, completion: @escaping (AddressFormResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/address/\(addressId)/status")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: headers)
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
    
    // MARK: 주소 목록 조회
    static func getAddressList(completion: @escaping (AddressListResultData) -> Void) {
        guard let storeId = UserDefaults.standard.string(forKey: "storeId"), let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/stores/\(storeId)/address")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AddressListResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 주소 단 건 조회
    static func getAddress(addressId: Int, completion: @escaping (AddressSingleResultData) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://idha-etu.shop/api/address/\(addressId)")!
        
        let headers: HTTPHeaders = [
            "X-ACCESS-TOKEN": token,
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: AddressSingleResultData.self) { response in
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
