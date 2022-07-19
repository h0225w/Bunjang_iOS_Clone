//
//  TabBarView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit

class TabBarView: UITabBarController {
    override func viewDidLoad() {
        view.tintColor = .black
        self.delegate = self
    }
}

// MARK: - UITabBarControllerDelegate
extension TabBarView: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: ProductRegisterView.identifier) as! ProductRegisterView
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
