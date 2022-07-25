//
//  PaymentSelectTableViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/25.
//

import UIKit

class PaymentSelectTableViewCell: UITableViewCell {
    static let identifier = "PaymentSelectTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var paymentDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    func updateUI(_ data: PaymentListResult) {
        nameLabel.text = data.productName
        priceLabel.text = "\(data.price)원"
        storeNameLabel.text = data.productStoreName
        paymentDateLabel.text = data.date
    }
}
