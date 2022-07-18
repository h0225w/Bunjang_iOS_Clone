//
//  CertNumberView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class CertNumberView: UIViewController {
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var certNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Extension
    
    // MARK: 확인 버튼 눌렀을 때
    @IBAction func didTapConfirmButton(_ sender: Any) {
        let certNumber = certNumberTextField.text ?? ""
        
        if certNumber != "" {
            LoginService.checkCertNumber(code: certNumber) { [weak self] data in
                if data.isSuccess {
                    UserDefaults.standard.set(data.result.storeID, forKey: "storeId")
                    UserDefaults.standard.set(data.result.jwt, forKey: "jwtToken")
                    
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "InputShopNameView") as! InputShopNameView
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alert = Helper().alert(title: "인증번호 오류", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

// MARK: - Extension
private extension CertNumberView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: 뷰 설정
    func setupViews() {
        let certNumber = UserDefaults.standard.string(forKey: "certNumber")
        
        certNumberTextField.addBottomBorder()
        certNumberTextField.text = certNumber
    }
}
