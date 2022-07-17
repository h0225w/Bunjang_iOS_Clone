//
//  HomeView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class HomeView: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
}

// MARK: - Extension
private extension HomeView {
    // MARK: 네비게이션 바 설정
    func setupNavigationBar() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = .white
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.configureWithTransparentBackground()

        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
    }
    
    // MARK: 뷰 설정
    func setupViews() {
        scrollView.delegate = self
    }
}

extension HomeView: UIScrollViewDelegate {
    // TODO: 스크롤 했을 때 NavigationBar tint color 바꾸는 방법
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            navigationController?.navigationBar.tintColor = .black
        } else {
            navigationController?.navigationBar.tintColor = .white
        }
    }
}
