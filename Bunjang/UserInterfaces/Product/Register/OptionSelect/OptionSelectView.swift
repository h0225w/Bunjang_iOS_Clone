//
//  OptionSelectView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import UIKit

class OptionSelectView: UIViewController {
    static let identifier = "OptionSelectView"
    
    var completion: (([String]) -> Void)?
    
    var used: Int = 0
    var exchange: Int = 0
    var deliveryCharge: Int = 0
    
    var usedText: String = "중고상품"
    var exchangeText: String = "교환불가"
    var deliveryChargeText: String = "배송비포함"
    
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet var usedButton: [UIButton]!
    @IBOutlet var exchangeButton: [UIButton]!
    @IBOutlet var deliveryChargeButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Actions
    @IBAction func didTapCompleteButton(_ sender: Any) {
        let count = "\(countTextField.text ?? "")개"
        
        completion?([count, usedText, exchangeText, deliveryChargeText])
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Extension
private extension OptionSelectView {
    // MARK: View 설정
    func setupViews() {
        usedButton.forEach {
            setupButton($0)
            $0.addTarget(self, action: #selector(didTapUsedButton(_:)), for: .touchUpInside)
        }
        
        exchangeButton.forEach {
            setupButton($0)
            $0.addTarget(self, action: #selector(didTapExchangeButton(_:)), for: .touchUpInside)
        }
        
        deliveryChargeButton.forEach {
            setupButton($0)
            $0.addTarget(self, action: #selector(didTapDeliveryChargeButton(_:)), for: .touchUpInside)
        }
        
        usedButton[used].backgroundColor = .systemPink
        exchangeButton[exchange].backgroundColor = .systemPink
        deliveryChargeButton[deliveryCharge].backgroundColor = .systemPink
    }
    
    // MARK: 상품상태
    @objc func didTapUsedButton(_ sender: UIButton) {
        used = sender.tag
        
        usedButton[used].backgroundColor = .systemPink
        
        if used > 0 {
            usedText = "중고상품"
            usedButton[0].backgroundColor = .white
        } else {
            usedText = "새상품"
            usedButton[1].backgroundColor = .white
        }
    }
    
    // MARK: 교환
    @objc func didTapExchangeButton(_ sender: UIButton) {
        exchange = sender.tag
        
        exchangeButton[exchange].backgroundColor = .systemPink
        
        if exchange > 0 {
            exchangeText = "교환불가"
            exchangeButton[0].backgroundColor = .white
        } else {
            exchangeText = "교환가능"
            exchangeButton[1].backgroundColor = .white
        }
    }
    
    // MARK: 배송비포함
    @objc func didTapDeliveryChargeButton(_ sender: UIButton) {
        deliveryCharge = sender.tag
        
        deliveryChargeButton[deliveryCharge].backgroundColor = .systemPink
        
        if deliveryCharge > 0 {
            deliveryChargeText = "배송비포함"
            deliveryChargeButton[0].backgroundColor = .white
        } else {
            deliveryChargeText = "배송비별도"
            deliveryChargeButton[1].backgroundColor = .white
        }
    }
    
    func setupButton(_ btn: UIButton) {
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
    }
}
