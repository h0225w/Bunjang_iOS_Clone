//
//  ReviewView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/24.
//

import UIKit

class ReviewView: UIViewController {
    static let identifier = "ReviewView"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Actions
    
    // MARK: 상점후기쓰기 눌렀을 때
    @IBAction func didTapReviewFormButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: ReviewFormView.identifier) as! ReviewFormView
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension
private extension ReviewView {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: ReviewCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ReviewView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.identifier, for: indexPath) as! ReviewCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableView", for: indexPath)
            return headerView
        default:
            assert(false)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ReviewView: UICollectionViewDelegateFlowLayout {
    // TODO: collectionView 동적 높이 구하는 법
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = 70
            return CGSize(width: width, height: height)
    }
}
