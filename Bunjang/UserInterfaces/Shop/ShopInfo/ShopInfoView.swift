//
//  ShopInfoView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import UIKit

class ShopInfoView: UIViewController {
    static let identifier = "ShopInfoView"
    
    // MARK: 프로필
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileReviewLabel: UILabel!
    @IBOutlet weak var profileInfoLabel: UILabel!
    
    // MARK: 상점 정보
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var saleCountLabel: UILabel!
    
    // MARK: 상점 소개
    @IBOutlet weak var introduceLabel: UILabel!
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var followButton: UIButton!
    
    var storeId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupData()
        setupShopProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: 뒤로가기 버튼 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: 팔로우 버튼 눌렀을 때
    @IBAction func didTapFollowButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let follow = sender.isSelected ? "팔로우" : "팔로우 해제"

        if let storeId = storeId {
            ShopService.follow(followeeId: storeId) { [weak self] data in
                if data.isSuccess {
                    self?.setupData()
                    let alert = Helper().alert(title: "\(follow) 성공", msg: data.message)
                    self?.present(alert, animated: true)
                } else {
                    let alert = Helper().alert(title: "\(follow) 실패", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

// MARK: - Extension
private extension ShopInfoView {
    func setupViews() {
        followButton.setTitle("팔로우", for: .normal)
        followButton.setTitle("팔로잉", for: .selected)
    }
    
    // MARK: 상점 정보 데이터 가져오기
    func setupData() {
        if let storeId = storeId {
            ShopService.getShopInfo(storeId: storeId) { [weak self] data in
                guard let self = self else { return }
                
                self.profileNameLabel.text = data.result.storeName
                self.profileReviewLabel.text = "★ \(data.result.rating) (\(data.result.ratingCount))"
                self.profileInfoLabel.text = "오픈일 +\(data.result.openDate) 방문수 \(data.result.visitCount)"
                self.productCountLabel.text = "\(data.result.productCount)"
                self.reviewCountLabel.text = "\(data.result.reviewCount)"
                self.followingCountLabel.text = "\(data.result.followingCount)"
                self.followerCountLabel.text = "\(data.result.followerCount)"
                self.saleCountLabel.text = "\(data.result.saleCount)회"
                
                self.followButton.isSelected = data.result.follow
            }
        }
    }
    
    // MARK: 상점 상품 목록 설정
    func setupShopProducts() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productCollectionView.register(UINib(nibName: ShopProductCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShopProductCollectionViewCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ShopInfoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopProductCollectionViewCell.identifier, for: indexPath) as! ShopProductCollectionViewCell
        cell.updateUI("")
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShopInfoView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 20, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
