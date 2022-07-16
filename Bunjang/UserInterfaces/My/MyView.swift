//
//  MyView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class MyView: UIViewController {
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopQnaButton: UIButton!
    @IBOutlet weak var tabView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

// MARK: - Extension
private extension MyView {
    func setupViews() {
        shopImageView.layer.cornerRadius = 30
        
        shopQnaButton.layer.borderWidth = 1
        shopQnaButton.layer.borderColor = UIColor.lightGray.cgColor
        shopQnaButton.layer.cornerRadius = 12
    }
}
