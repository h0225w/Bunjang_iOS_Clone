//
//  ProductListView.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/16.
//

import UIKit
import Tabman
import Pageboy

class ProductListView: TabmanViewController {
    
    // 판매 상태 목록 (판매중, 예약중, 판매완료)
    private var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}
