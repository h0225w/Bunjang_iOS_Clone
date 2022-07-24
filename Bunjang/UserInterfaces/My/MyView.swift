//
//  MyView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class MyView: UIViewController {
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopQnaButton: UIButton!
    @IBOutlet weak var tabView: UIView!
    
    // MARK: 프로필
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileReviewLabel: UILabel!
    
    // MARK: 내 정보
    @IBOutlet weak var dibsCountLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupData()
    }
    
    // MARK: - Action
    
    // MARK: 설정 버튼 눌렀을 때
    @IBAction func didTapSettingButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: SettingView.identifier) as! SettingView
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension
private extension MyView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationItem.backButtonTitle = ""
    }
    
    // MARK: View 설정
    func setupViews() {
        shopImageView.layer.cornerRadius = 30
        
        shopQnaButton.layer.borderWidth = 1
        shopQnaButton.layer.borderColor = UIColor.lightGray.cgColor
        shopQnaButton.layer.cornerRadius = 12
    }
    
    // MARK: 내 정보 가져오기
    func setupData() {
        guard let storeId = UserDefaults.standard.string(forKey: "storeId") else { return }
        
        ShopService.getShopInfo(storeId: Int(storeId)!) { [weak self] data in
            guard let self = self else { return }
            
            self.profileNameLabel.text = "\(data.result.storeName)"
            self.profileReviewLabel.text = "★ \(data.result.rating)"
            self.dibsCountLabel.text = "\(data.result.dibsCount)"
            self.reviewCountLabel.text = "\(data.result.reviewCount)"
            self.followerCountLabel.text = "\(data.result.followerCount)"
            self.followingCountLabel.text = "\(data.result.followingCount)"
        }
    }
}
