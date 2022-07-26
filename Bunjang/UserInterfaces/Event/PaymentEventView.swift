//
//  PaymentEventView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/26.
//

import UIKit

class PaymentEventView: UIViewController {
    static let identifier = "PaymentEventView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
