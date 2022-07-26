//
//  Helper.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/18.
//

import UIKit
import Alamofire

class Helper {
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
    
    // MARK: 숫자 세 자리마다 콤마 찍기
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
