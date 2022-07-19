//
//  ShopInfoView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import UIKit

class ShopInfoView: UIViewController {
    static let identifier = "ShopInfoView"
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupShopProducts()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension
private extension ShopInfoView {
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
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
