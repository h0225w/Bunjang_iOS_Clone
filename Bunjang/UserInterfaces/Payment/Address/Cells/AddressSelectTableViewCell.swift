//
//  AddressSelectTableViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

class AddressSelectTableViewCell: UITableViewCell {
    static let identifier = "AddressSelectTableViewCell"
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(_ data: AddressListResult) {
        addressLabel.text = data.content + " " + data.detail
        nameLabel.text = data.name
    }
    
}
