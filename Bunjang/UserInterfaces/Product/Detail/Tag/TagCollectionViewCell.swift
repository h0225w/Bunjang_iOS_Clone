//
//  TagCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    static let identifier = "TagCollectionViewCell"
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
    }
    
    func updateUI(_ text: String) {
        label.text = text
    }
}
