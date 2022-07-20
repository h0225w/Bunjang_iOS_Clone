//
//  ImageBannerCollectionViewCell.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit
import Kingfisher

class ImageBannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageBannerCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
    }
    
    func updateUI(_ image: String) {
        if image != "" {
            let imageUrl = URL(string: image)
            
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: imageUrl)
        } else {
            imageView.backgroundColor = .random
        }
    }
}

extension UIColor {
    static var random: UIColor {
        return .init(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 1)
    }
}
