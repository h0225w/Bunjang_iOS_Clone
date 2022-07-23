//
//  AddressManageCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressManageCollectionViewCell: UICollectionViewCell {
    static let identifier = "AddressManageCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 5
    }
    
    func updateUI(_ data: AddressListResult) {
        nameLabel.text = data.name
        addressLabel.text = data.content
        phoneLabel.text = data.phone
    }
}
