//
//  LoginService.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/18.
//

import Foundation
import Alamofire
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

// MARK: - 로그인 관련 API
class LoginService {
    // MARK: - 일반 로그인
    
    // MARK: 회원가입 / 로그인
    static func login(name: String, phone: String, birthDate: String, completion: @escaping (LoginResultData) -> Void) {
        let url = URL(string: "https://dev.idha-etu.shop/api/stores")!
        
        let params = [
            "name": name,
            "phone": phone,
            "birthDate": birthDate
        ]
        
        let request = Helper.makeRequest(url, method: "POST", dict: params)
                                 
        AF.request(request)
            .responseDecodable(of: LoginResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 인증번호 확인
    static func checkCertNumber(code: String, completion: @escaping (CertNumberResultData) -> Void) {
        let url = URL(string: "https://dev.idha-etu.shop/api/stores/code")!
        
        let params = [
            "code": code
        ]
        
        let request = Helper.makeRequest(url, method: "POST", dict: params)
                                 
        AF.request(request)
            .responseDecodable(of: CertNumberResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: 상점 이름 설정
    static func setShopName(storeName: String, completion: @escaping (ShopNameResultData) -> Void) {
        guard let storeId = UserDefaults.standard.string(forKey: "storeId"), let token = UserDefaults.standard.string(forKey: "jwtToken") else { return }
        
        let url = URL(string: "https://dev.idha-etu.shop/api/stores/\(storeId)/name")!
        
        let params = [
            "storeName": storeName
        ]
        
        let request = Helper.makeRequest(url, method: "PATCH", dict: params, token: token)

        AF.request(request)
            .responseDecodable(of: ShopNameResultData.self) { response in
                switch response.result {
                case .success:
                    guard let data = response.value else { return }
                    completion(data)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    // MARK: - 카카오 로그인
    static func kakaoLogin(completion: @escaping () -> Void) {
        // 카카오톡이 설치되어 있는 경우
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카카오 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    self.getKakaoUserInfo(completion: completion)
                }
            }
        } else {
            // 카카오 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.getKakaoUserInfo(completion: completion)
                    }
                }
        }
    }
    
    // MARK: 카카오 로그인 > 사용자 정보
    static func getKakaoUserInfo(completion: @escaping () -> Void) {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            } else {
                print("me() success.")
                
                let nickname = user?.kakaoAccount?.profile?.nickname ?? ""
                let gender = user?.kakaoAccount?.gender?.rawValue ?? ""
                let birthDay = user?.kakaoAccount?.birthday ?? ""
                completion()
            }
        }
    }
}
