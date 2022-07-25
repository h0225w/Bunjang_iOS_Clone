//
//  ReviewFormView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/24.
//

import UIKit
import Cosmos

class ReviewFormView: UIViewController {
    static let identifier = "ReviewFormView"
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var textView: UITextView!
    
    let textViewPlaceholder = "거래와 관련없는 후기는 삭제될 수 있습니다. 최소 20자 이상 입력 해주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCosmosView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions
    
    // MARK: 뒤로가기 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension
private extension ReviewFormView {
    func setupViews() {
        textView.text = textViewPlaceholder
        textView.textColor = .placeholderText
        textView.delegate = self
    }
    
    // MARK: 별점
    func setupCosmosView() {
        cosmosView.rating = 5
        cosmosView.settings.updateOnTouch = true
        cosmosView.settings.fillMode = .half
        cosmosView.settings.starSize = 50
    }
}

// MARK: - UITextViewDelegate
extension ReviewFormView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = .placeholderText
        }
    }
}
