//
//  ProductCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/18.
//

import UIKit
import Kingfisher

// MARK: - 이 상점의 상품 목록
class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        productImageView.layer.masksToBounds = true
    }

    func updateUI(_ data: StoreInfoProduct) {
        let imageUrl = URL(string: data.productImage)
        
        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(with: imageUrl)
        productPriceLabel.text = "\(data.price)원"
        productNameLabel.text = data.name
    }
}
