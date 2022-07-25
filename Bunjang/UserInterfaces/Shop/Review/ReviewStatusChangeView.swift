//
//  ReviewStatusChangeView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/25.
//

import UIKit

class ReviewStatusChangeView: UIViewController {
    static let identifier = "ReviewStatusChangeView"
    
    var completion: ((Bool) -> Void)?
    var reviewId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    // MARK: 닫기 버튼 눌렀을 때
    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: 수정하기 버튼 눌렀을 때
    @IBAction func didTapEditButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ReviewFormView.identifier) as! ReviewFormView
        
        vc.reviewId = reviewId
        vc.completion = completion
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false)
    }
    
    // MARK: 삭제하기 버튼 눌렀을 때
    @IBAction func didTapDeleteButton(_ sender: Any) {
        guard let reviewId = reviewId else { return }
        
        ReviewService.delete(reviewId: reviewId) { [weak self] data in
            if data.isSuccess {
                let action: (() -> Void) = {
                    self?.dismiss(animated: true)
                    self?.completion?(true)
                }
                
                let alert = Helper().alert(title: "후기 삭제 성공", msg: data.message, action: action)
                self?.present(alert, animated: true)
            } else {
                let alert = Helper().alert(title: "후기 삭제 실패", msg: data.message)
                self?.present(alert, animated: true)
            }
        }
    }
}
