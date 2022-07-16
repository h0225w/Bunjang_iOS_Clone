//
//  TabManView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit
import Tabman
import Pageboy

class TabManView: TabmanViewController {
    
    // 판매 상태 목록 (판매중, 예약중, 판매완료)
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabMan()
    }
}

// MARK: - Extension
private extension TabManView {
    // MARK: 판매 상태 목록 화면 설정 (판매중, 예약중, 판매완료)
    func setupTabMan() {
        let vc1 = storyboard?.instantiateViewController(withIdentifier: "ProductListView") as! ProductListView
        let vc2 = storyboard?.instantiateViewController(withIdentifier: "ProductListView") as! ProductListView
        let vc3 = storyboard?.instantiateViewController(withIdentifier: "ProductListView") as! ProductListView
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        // TODO: 전환 모션 안 되게 하고 싶음
        bar.layout.transitionStyle = .none
        
        bar.backgroundView.style = .blur(style: .light)

        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

        bar.buttons.customize { (button) in
            button.tintColor = .systemGray4
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            button.selectedFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        }
        
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = .black
        addBar(bar, dataSource: self, at: .top)
    }
}

extension TabManView: PageboyViewControllerDataSource, TMBarDataSource {
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
            return TMBarItem(title: "판매중")
        case 1:
            return TMBarItem(title: "예약중")
        case 2:
            return TMBarItem(title: "판매 완료")
        default:
            return TMBarItem(title: "page \(index)")
        }
    }
}
