//
//  RecommendProductListView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit

class RecommendProductListView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var products: [HomeProductsResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
    }
}

// MARK: - Extension
private extension RecommendProductListView {
    // MARK: 추천 상품 목록 설정
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: RecommendProductCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecommendProductCollectionViewCell.identifier)
    }
    
    // MARK: 추천 상품 목록 데이터 가져오기
    func setupData() {
        HomeService.getProducts { [weak self] data in
            guard let self = self else { return }
            
            self.products = data.result
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionVieWDataSource
extension RecommendProductListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendProductCollectionViewCell.identifier, for: indexPath) as! RecommendProductCollectionViewCell
        
        if let products = products {
            cell.updateUI(products[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ProductDetailView.identifier) as! ProductDetailView
        
        if let products = products {
            vc.productId = products[indexPath.row].productId
        }
        
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendProductListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2 - 25, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
}
