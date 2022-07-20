//
//  ProductDetailView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit

class ProductDetailView: UIViewController {
    static let identifier = "ProductDetailView"
    
    var productId: Int?
    var storeId: Int?
    
    @IBOutlet weak var imageBannerCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productInfoLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var usedLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var storeInfoLabel: UILabel!
    
    // TODO: 상품 후기는 후기 개발 완료 후 진행 예정
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: 이미지 배너 관련 변수
    var timer: DispatchSourceTimer?
    var currentCellIndex = 0
    var images: [String] = []
    
    // MARK: 태그 목록 관련 변수
    var letters: [String]?
    
    // MARK: 이 상점의 상품 목록 관련 변수
    var products: [StoreInfoProduct]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupImageBanner()
        setupTags()
        setupProducts()
        setupData()
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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        imageBannerCollectionView.collectionViewLayout = layout
        imageBannerCollectionView.clipsToBounds = true
        
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
        
        let layout = UICollectionViewFlowLayout()
        productCollectionView.collectionViewLayout = layout
        productCollectionView.clipsToBounds = true
        
        productCollectionView.register(UINib(nibName: ProductCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
    
    // MARK: 상품 상세 데이터 가져오기
    func setupData() {
        guard let productId = productId else { return }
        
        ProductService.getProductDetail(productId) { [weak self] data in
            guard let self = self else { return }
            
            self.storeId = data.result.storeInformation.storeID
            
            self.images = data.result.image
            self.letters = data.result.tag
            self.products = data.result.storeInformation.product
            
            self.productPriceLabel.text = "\(data.result.price)원"
            self.productNameLabel.text = "\(data.result.name)"
            self.productInfoLabel.text = "\(data.result.date)"
            self.productCountLabel.text = "❤️ \(data.result.dibsCount)"
            self.usedLabel.text = "\(data.result.used ? "중고상품" : "새상품")"
            self.countLabel.text = "총 \(data.result.count)개"
            self.deliveryChargeLabel.text = "\(data.result.includeDeliveryCharge ? "배송비포함" : "배송비별도")"
            self.exchangeLabel.text = "\(data.result.exchange ? "교환가능" : "교환불가")"
            self.contentLabel.text = data.result.content
            self.storeNameLabel.text = data.result.storeInformation.storeName
            self.storeInfoLabel.text = "★ \(data.result.storeInformation.rating) ﹒ 팔로워 \(data.result.storeInformation.followerCount)"
            
            self.imageBannerCollectionView.reloadData()
            self.tagCollectionView.reloadData()
            self.productCollectionView.reloadData()
        }
    }
    
    // MARK: 검색 버튼 눌렀을 때
    @objc func didTapSearchButton() {
        
    }
    
    // MARK: 공유 버튼 눌렀을 때
    @objc func didTapActionButton() {
        
    }
    
    // MARK: 프로필 이미지 눌렀을 때
    @objc func didTapProfileImage(_ sender: AnyObject) {
        if let storeId = storeId {
            let vc = storyboard?.instantiateViewController(withIdentifier: ShopInfoView.identifier) as! ShopInfoView
            vc.storeId = storeId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProductDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imageBannerCollectionView:
            return images.count
        case tagCollectionView:
            if let letters = letters {
                return letters.count
            } else {
                return 0
            }
        default:
            if let products = products {
                return products.count
            } else {
                return 0
            }
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
            if let letters = letters {
                cell.updateUI(letters[indexPath.row])
            }
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as! ProductCollectionViewCell
            if let products = products {
                cell.updateUI(products[indexPath.row])
            }
            
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
