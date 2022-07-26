//
//  EventView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/26.
//

import UIKit

class EventView: UIViewController {
    static let identifier = "EventView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}

// MARK: - Extension
private extension EventView {
    func setupNavigationBar() {
        let label = UILabel()
        label.textColor = .label
        label.text = "번개장터 7월 혜택"
        navigationItem.leftBarButtonItem = .init(customView: label)
        navigationItem.leftItemsSupplementBackButton = true
        
        let actionButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapActionButton))
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapCloseButton))
        
        navigationItem.rightBarButtonItems = [actionButton, closeButton]
    }
    
    // MARK: 공유 버튼 눌렀을 때
    @objc func didTapActionButton() {
        
    }
    
    // MARK: 닫기 버튼 눌렀을 때
    @objc func didTapCloseButton() {
        navigationController?.popViewController(animated: true)
    }
}
