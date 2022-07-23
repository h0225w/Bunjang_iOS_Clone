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
    
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressPhoneLabel: UILabel!
    
    // MARK: 배송지
    var address: AddressListResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: 배송지 주소 선택 버튼 눌렀을 때
    @IBAction func didTapAddressSelectButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddressSelectView.identifier) as! AddressSelectView
        
        vc.completion = { [weak self] data in
            guard let self = self else { return }
            
            self.addressNameLabel.text = data.name
            self.addressLabel.text = data.content + " " + data.detail
            self.addressPhoneLabel.text = data.phone
        }
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(vc, animated: true)
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
