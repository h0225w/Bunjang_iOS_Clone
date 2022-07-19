//
//  Helper.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/18.
//

import UIKit
import Alamofire

class Helper {
    // MARK: API 요청 시 사용하는 request 생성
    static func makeRequest(_ url: URL, method: String, dict: [String: String]?, token: String = "") -> URLRequest {
        var jsonString: String = ""
        
        var request = URLRequest(url: url)
            
        request.httpMethod = method
        if token != "" { request.setValue("X-ACCESS-TOKEN", forHTTPHeaderField: token) }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let dict = dict {
            do{
                let jsonEncoder = JSONEncoder()
                let jsonData = try jsonEncoder.encode(dict)
                jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
            } catch { }
            
            request.httpBody = (jsonString).data(using: .unicode)
        }
        
        return request
    }
    
    // MARK: Alert 생성
    func alert(title: String, msg: String, action: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let action = action else { return }
            action()
        }
        alert.addAction(okAction)
        
        return alert
    }
}
