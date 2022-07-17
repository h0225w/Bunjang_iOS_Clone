//
//  ImageBannerCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit

class ImageBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageBannerCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(_ image: String) {
//        imageView.image = UIImage(named: image)
        imageView.backgroundColor = .random
    }
}

extension UIColor {
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
