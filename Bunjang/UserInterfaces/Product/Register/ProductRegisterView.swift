//
//  ProductRegisterView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import UIKit

class ProductRegisterView: UIViewController {
    static let identifier = "ProductRegisterView"
    
    var safePayment: Bool = true
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var optionSelectButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var optionLabel: UILabel!
    
    @IBOutlet weak var safePaymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Actions
    
    // MARK: 뒤로 가기
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: 옵션 선택 버튼 눌렀을 때
    @IBAction func didTapOptionSelectButton(_ sender: Any) {
        presentModal()
    }
    
    // MARK: 안전결제 환영 눌렀을 때
    @IBAction func didTapSafePaymentButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        safePayment = sender.isSelected
        
        if sender.isSelected {
            sender.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            sender.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // MARK: 등록 눌렀을 때
    @IBAction func didTapRegisterButton(_ sender: Any) {
    }
}

// MARK: - Extension
extension ProductRegisterView {
    // MARK: View 설정
    func setupViews() {
        [nameTextField, categoryTextField, tagTextField, priceTextField].forEach {
            $0?.addBottomBorder()
        }
        
        optionSelectButton.layer.borderColor = UIColor.lightGray.cgColor
        optionSelectButton.layer.borderWidth = 1
        optionSelectButton.layer.cornerRadius = 5
        
        safePaymentButton.layer.borderColor = UIColor.systemRed.cgColor
        safePaymentButton.layer.borderWidth = 1
        safePaymentButton.layer.cornerRadius = 5
        
        safePaymentButton.isSelected = true
    }
    
    // MARK: 옵션 선택 창 열기
    func presentModal() {
        let vc = storyboard?.instantiateViewController(withIdentifier: OptionSelectView.identifier) as! OptionSelectView
        
        vc.modalPresentationStyle = .pageSheet
        vc.completion = { data in
            self.optionLabel.text = "\(data[0])﹒\(data[1])﹒\(data[2])﹒\(data[3])"
        }
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        
        self.present(vc, animated: true)
    }
}
