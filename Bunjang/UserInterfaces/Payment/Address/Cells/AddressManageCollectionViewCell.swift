//
//  AddressManageCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressManageCollectionViewCell: UICollectionViewCell {
    static let identifier = "AddressManageCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 5
    }

}
