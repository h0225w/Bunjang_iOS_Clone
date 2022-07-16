//
//  UITextField+Extension.swift
//  Dobit
//
//  Created by 박현우 on 2022/07/12.
//

import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
}
