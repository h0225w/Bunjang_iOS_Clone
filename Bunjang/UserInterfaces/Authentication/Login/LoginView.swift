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
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Extension
    
    // MARK: 확인 버튼 눌렀을 때
    @IBAction func didTapConfirmButton(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let birth = (birthFrontTextField.text ?? "") + (birthBackTextField.text ?? "")
        
        if name != "" && phone != "" && birth != "" {
            LoginService.login(name: name, phone: phone, birthDate: birth) { [weak self] data in
                if data.isSuccess {
                    UserDefaults.standard.set(data.result.code, forKey: "certNumber")
                    
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CertNumberView") as! CertNumberView
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alert = Helper().alert(title: "로그인 실패", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

// MARK: - Extension
private extension LoginView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: 뷰 설정
    func setupViews() {
        [phoneTextField, agencyTextField, birthFrontTextField, birthBackTextField, nameTextField].forEach {
            $0?.addBottomBorder()
        }
        
        phoneTextField.delegate = self
        birthFrontTextField.delegate = self
        birthBackTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    // MARK: textField 최대 입력 가능 길이 설정
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let rangeOfTextToReplace = Range(range, in: text) else {
            return false
        }
        
        let subStringToReplace = text[rangeOfTextToReplace]
        let count = text.count - subStringToReplace.count + string.count
        
        switch textField {
        case phoneTextField:
            return count <= 11
        case birthFrontTextField:
            return count <= 6
        default:
            return count <= 1
        }
    }
}
