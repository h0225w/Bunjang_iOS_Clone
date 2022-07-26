//
//  RecommendProductCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit
import Kingfisher

class RecommendProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendProductCollectionViewCell"
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.contentMode = .scaleAspectFill
    }
    
    func updateUI(_ data: HomeProductsResult) {
        let imageUrl = URL(string: data.productImage)
        
        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(with: imageUrl)
        productPriceLabel.text = "\(Helper().numberFormatter(number: data.price))원"
        productNameLabel.text = data.name
        productInfoLabel.text = data.date
    }
}
