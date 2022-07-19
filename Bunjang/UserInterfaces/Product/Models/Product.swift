//
//  Product.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/19.
//

import Foundation

// MARK: - Entity
struct Product {
    let name, category, content: String
    let price, count: Int
    let safePayment, deliveryCharge, used, exchange: Bool
    let tag, images: [String]
}
