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
    @IBOutlet weak var paymentMethodView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    // MARK: 닫기 버튼 눌렀을 때
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

// MARK: - Extension
private extension PaymentView {
    func setupViews() {
        [addressView, paymentView, paymentMethodView].forEach {
            $0?.layer.borderColor = UIColor.systemGray5.cgColor
            $0?.layer.borderWidth = 1
            $0?.layer.cornerRadius = 5
        }
    }
}
