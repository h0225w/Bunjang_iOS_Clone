//
//  ReviewCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/24.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    static let identifier = "ReviewCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(_ data: ReviewListResult) {
        nameLabel.text = data.storeName
        ratingLabel.text = "\(data.rating)"
        contentLabel.text = data.content
        dateLabel.text = data.date
        productNameLabel.text = "구매 상품: " + data.productName
    }
}
