//
//  LoginView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class LoginView: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var agencyTextField: UITextField!
    @IBOutlet weak var birthFrontTextField: UITextField!
    @IBOutlet weak var birthBackTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Extension
    
    // MARK: 확인 버튼 눌렀을 때
    @IBAction func didTapConfirmButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CertNumberView") as! CertNumberView
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension
private extension LoginView {
    // MARK: 뷰 설정
    func setupViews() {
        [phoneTextField, agencyTextField, birthFrontTextField, birthBackTextField, nameTextField].forEach {
            $0?.addBottomBorder()
        }
    }
}
