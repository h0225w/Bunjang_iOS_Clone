//
//  AddressManageCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import UIKit

protocol AddressManageCollectionViewCellDelegate: AnyObject {
    func moveToEditForm(addressId: Int)
    func delete(addressId: Int)
}

class AddressManageCollectionViewCell: UICollectionViewCell {
    static let identifier = "AddressManageCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    weak var delegate: AddressManageCollectionViewCellDelegate?
    
    var addressId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray5.cgColor
        layer.cornerRadius = 5
    }
    
    // MARK: 수정 버튼 눌렀을 때
    @IBAction func didTapEditButton(_ sender: Any) {
        if let addressId = addressId {
            delegate?.moveToEditForm(addressId: addressId)
        }
    }
    
    // MARK: 삭제 버튼 눌렀을 때
    @IBAction func didTapDeleteButton(_ sender: Any) {
        if let addressId = addressId {
            delegate?.delete(addressId: addressId)
        }
    }
    
    func updateUI(_ data: AddressListResult) {
        nameLabel.text = data.name
        addressLabel.text = data.content
        phoneLabel.text = data.phone
        
        addressId = data.addressID
    }
}
