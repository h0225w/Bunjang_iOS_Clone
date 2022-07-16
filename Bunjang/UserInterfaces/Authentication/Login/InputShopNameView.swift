//
//  InputShopNameView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class InputShopNameView: UIViewController {
    @IBOutlet weak var shopNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Extension
    
    // MARK: 확인 버튼 눌렀을 때
    @IBAction func didTapConfirmButton(_ sender: Any) {
        
    }
}

// MARK: - Extension
private extension InputShopNameView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: 뷰 설정
    func setupViews() {
        shopNameTextField.addBottomBorder()
    }
}
