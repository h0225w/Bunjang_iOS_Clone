//
//  Payment.swift
//  Bunjang
//
//  Created by 박현우 on 2022/07/23.
//

import Foundation

struct Payment {
    let productId: Int
    let addressId: Int
    let parcel: Bool
    let request: String
    let paymentMethod: String
    let usingPoint: Int
}
