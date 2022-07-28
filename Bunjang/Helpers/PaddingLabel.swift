//
//  PaddingLabel.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/28.
//

import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
