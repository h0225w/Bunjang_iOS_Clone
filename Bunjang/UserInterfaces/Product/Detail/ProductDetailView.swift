//
//  ProductDetailView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit

class ProductDetailView: UIViewController {
    static let identifier = "ProductDetailView"
    
    @IBOutlet weak var imageBannerCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: 이미지 배너 관련 변수
    var timer: DispatchSourceTimer?
    var currentCellIndex = 0
    var images = [
        "",
        "",
        "",
        "",
        ""
    ]
    
    // MARK: 태그 목록 관련 변수
    var letters = ["발렌시아가", "트레이닝 하의", "발렌시아가트랙팬츠", "#발렌시아가그레이", "#트랙팬츠"]
    
    // MARK: 이 상점의 상품 목록 관련 변수
    var products = ["", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupImageBanner()
        setupTags()
        setupProducts()
    }
}

// MARK: - Extension
private extension ProductDetailView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        let actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActionButton))
        
        navigationItem.rightBarButtonItems = [searchButton, actionButton]
    }
    
    // MARK: View 설정
    func setupViews() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImage(_:)))
        
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: 이미지 배너 설정
    func setupImageBanner() {
        imageBannerCollectionView.delegate = self
        imageBannerCollectionView.dataSource = self
        
        imageBannerCollectionView.register(UINib(nibName: ImageBannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ImageBannerCollectionViewCell.identifier)
    }
    
    // MARK: 태그 목록 설정
    func setupTags() {
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        tagCollectionView.register(UINib(nibName: TagCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        tagCollectionView.collectionViewLayout = CollectionViewLeftAlignFlowLayout()
        
        if let flowLayout = tagCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    // MARK: 이 상점의 상품 설정
    func setupProducts() {
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productCollectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
    
    // MARK: 검색 버튼 눌렀을 때
    @objc func didTapSearchButton() {
        
    }
    
    // MARK: 공유 버튼 눌렀을 때
    @objc func didTapActionButton() {
        
    }
    
    // MARK: 프로필 이미지 눌렀을 때
    @objc func didTapProfileImage(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ShopInfoView.identifier) as! ShopInfoView
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProductDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imageBannerCollectionView:
            return images.count
        case tagCollectionView:
            return letters.count
        default:
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imageBannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageBannerCollectionViewCell.identifier, for: indexPath) as! ImageBannerCollectionViewCell
            cell.updateUI(images[indexPath.row])
            
            return cell
        case tagCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            cell.updateUI(letters[indexPath.row])
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
//            cell.updateUI(products[indexPath.row])
            
            return cell
        }
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProductDetailView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case imageBannerCollectionView:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        default:
            return CGSize(width: collectionView.frame.width / 3 - 20, height: 220)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case imageBannerCollectionView:
            return 0
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case productCollectionView:
            return 10
        default:
            return 0
        }
    }
}
