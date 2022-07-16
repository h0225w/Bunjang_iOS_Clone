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
        let vc = storyboard?.instantiateViewController(withIdentifier: "InputShopNameView") as! InputShopNameView
        navigationController?.pushViewController(vc, animated: true)
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
        certNumberTextField.addBottomBorder()
    }
}
