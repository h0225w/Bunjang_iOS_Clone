//
//  FirstView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit
import GoogleSignIn

class FirstView: UIViewController {
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationBar()
        setupViews()
    }
    
    // MARK: - Actions
    
    @IBAction func didTapKakaoLoginButton(_ sender: Any) {
        LoginService.kakaoLogin() {
            self.setRootViewController()
        }
    }
    
    @IBAction func didTapGoogleLoginButton(_ sender: Any) {
        let config = GIDConfiguration(clientID: "57949764592-5kb2dr7obokq5f4rdpc4ongj6jb2p1jd.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard let user = user else { return }
            
            self.setRootViewController()
        }
    }
    
    // MARK: 다른 방법으로 로그인 눌렀을 때
    @IBAction func didTapLoginButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginView") as! LoginView
        
        print(vc)
        print(navigationController)
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
        [kakaoLoginButton, googleLoginButton].forEach {
            $0?.layer.cornerRadius = 25
        }
        
        googleLoginButton.layer.borderColor = UIColor.black.cgColor
        googleLoginButton.layer.borderWidth = 1
    }
    
    // MARK: rootViewController
    func setRootViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarView") as! TabBarView
        self.view.window?.windowScene?.keyWindow?.rootViewController = vc
    }
}
