//
//  PaymentView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/21.
//

import UIKit

class PaymentView: UIViewController {
    static let identifier = "PaymentView"
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var paymentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Extension
private extension PaymentView {
    func setupViews() {
        [addressView, paymentView].forEach {
            $0?.layer.borderColor = UIColor.lightGray.cgColor
            $0?.layer.borderWidth = 1
            $0?.layer.cornerRadius = 5
        }
    }
}
