//
//  IndicatorView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/28.
//

import UIKit
import SnapKit
import Then

final class IndicatorView: UIView {
    // MARK: UI
    private let trackView = UIView().then {
        $0.backgroundColor = .lightGray.withAlphaComponent(0.3)
    }
    
    private let trackTintView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    // MARK: Properties
    var widthRatio: Double? {
        didSet {
            guard let widthRatio = widthRatio else { return }
            self.trackTintView.snp.remakeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(widthRatio)
                $0.left.greaterThanOrEqualToSuperview()
                $0.right.lessThanOrEqualToSuperview()
                self.leftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
            }
        }
    }
    
    var leftOffsetRatio: Double? {
        didSet {
            guard let leftOffsetRatio = leftOffsetRatio else { return }
            self.leftInsetConstraint?.update(inset: leftOffsetRatio * self.bounds.width)
        }
    }
    
    private var leftInsetConstraint: Constraint?
    
    // MARK: Initialize
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.trackView)
        self.trackView.addSubview(self.trackTintView)
        
        self.trackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.trackTintView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(1.0 / 5.0)
            $0.left.greaterThanOrEqualToSuperview()
            $0.right.lessThanOrEqualToSuperview()
            self.leftInsetConstraint = $0.left.equalToSuperview().priority(999).constraint
        }
    }
}
