//
//  FirstView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class FirstView: UIViewController {
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Actions
    
    // MARK: 다른 방법으로 로그인 눌렀을 때
    @IBAction func didTapLoginButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginView
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension
private extension FirstView {
    // MARK: 레이아웃 설정
    func setupLayout() {
        
    }
    
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: 뷰 설정
    func setupViews() {
        [kakaoLoginButton, appleLoginButton].forEach {
            $0?.layer.cornerRadius = 25
        }
        
        appleLoginButton.layer.borderColor = UIColor.black.cgColor
        appleLoginButton.layer.borderWidth = 1
    }
}
