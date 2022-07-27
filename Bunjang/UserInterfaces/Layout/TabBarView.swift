//
//  TabBarView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class TabBarView: UITabBarController {
    var index = 0
    
    override func viewDidLoad() {
        view.tintColor = .black
        self.delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarView: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.title == "등록" {
            index = 1
            
            let vc = storyboard?.instantiateViewController(withIdentifier: ProductRegisterView.identifier) as! ProductRegisterView

            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        } else {
            index = 0
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return index != 1
    }
}
