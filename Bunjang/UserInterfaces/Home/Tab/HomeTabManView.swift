//
//  HomeTabManView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/17.
//

import UIKit
import Tabman
import Pageboy

class HomeTabManView: TabmanViewController {
    
    // 추천상품, 브랜드 vc
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabMan()
    }
}

// MARK: - Extension
private extension HomeTabManView {
    // MARK: 추천상품, 브랜드 탭 구분
    func setupTabMan() {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "RecommendProductListView") as! RecommendProductListView
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "BrandListView") as! BrandListView
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .blur(style: .light)

        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        }
        
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .top)
    }
}

extension HomeTabManView: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "추천상품")
        case 1:
            return TMBarItem(title: "브랜드")
        default:
            return TMBarItem(title: "page \(index)")
        }
    }
}
