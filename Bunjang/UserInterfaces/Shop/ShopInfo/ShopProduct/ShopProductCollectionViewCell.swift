//
//  ShopProductCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import UIKit
import Kingfisher

class ShopProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ShopProductCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.contentMode = .scaleAspectFill
    }

    func updateUI(_ data: ShopProductsResult) {
        let imageUrl = URL(string: data.productImage)
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: imageUrl)
        priceLabel.text = "\(Helper().numberFormatter(number: data.price))원"
        nameLabel.text = data.name
    }
}
