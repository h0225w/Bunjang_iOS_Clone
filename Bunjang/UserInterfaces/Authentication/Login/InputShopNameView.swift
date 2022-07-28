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
    
    // MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Extension
    
    // MARK: 확인 버튼 눌렀을 때
    @IBAction func didTapConfirmButton(_ sender: Any) {
        let shopName = shopNameTextField.text ?? ""
        
        if shopName != "" {
            LoginService.setShopName(storeName: shopName) { [weak self] data in
                if data.isSuccess {
                    UserDefaults.standard.set(true, forKey: "isLogined")
                    
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TabBarView") as! TabBarView
                    self?.view.window?.windowScene?.keyWindow?.rootViewController = vc
                } else {
                    let alert = Helper().alert(title: "상점명 설정 오류", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
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
