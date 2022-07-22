//
//  AddressFormView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressFormView: UIViewController {
    static let identifier = "AddressFormView"
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var addressDetailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: 뒤로 가기 버튼 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
}

// MARK: - Extension
private extension AddressFormView {
    func setupViews() {
        [nameField, phoneField, addressField, addressDetailField].forEach {
            $0?.addBottomBorder()
        }
    }
}
