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
    
    var paymentId: Int?
    var reviewId: Int?
    
    var completion: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCosmosView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Actions
    
    // MARK: 뒤로가기 눌렀을 때
    @IBAction func didTapBackButton(_ sender: Any) {
        if let navigationController = navigationController{
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
    
    // MARK: 등록 눌렀을 때
    @IBAction func didTapSubmitButton(_ sender: Any) {
        let rating = cosmosView.rating
        let content = textView.text ?? ""
        
        if let reviewId = reviewId, content != "" {
            let review = Review(paymentId: 0, rating: rating, content: content)
            
            ReviewService.edit(review, reviewId: reviewId) { [weak self] data in
                if data.isSuccess {
                    self?.dismiss(animated: true)
                    self?.completion?(true)
                } else {
                    let alert = Helper().alert(title: "후기 수정 실패", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        } else if let paymentId = paymentId, content != "" {
            let review = Review(paymentId: paymentId, rating: rating, content: content)
            
            ReviewService.register(review) { [weak self] data in
                if data.isSuccess {
                    self?.navigationController?.popViewController(animated: false)
                    self?.completion?(true)
                } else {
                    let alert = Helper().alert(title: "후기 작성 실패", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
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
    
    func setupData() {
        if let reviewId = reviewId {
            ReviewService.getReviewSingle(reviewId: reviewId) { [weak self] data in
                if data.isSuccess {
                    guard let review = data.result else { return }
                    self?.textView.text = review.content
                    self?.textView.textColor = .label
                    self?.cosmosView.rating = review.rating
                } else {
                    let alert = Helper().alert(title: "후기 조회 실패", msg: data.message)
                    self?.present(alert, animated: true)
                }
            }
        }
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
