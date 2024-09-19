//
//  CouponModel.swift
//  dev
//
//  Created by phan dam tung lam on 10/8/24.
//

import Foundation

class Coupon: Identifiable, Equatable, Hashable, Decodable {
    let id: String
    var code: String
    var couponType: String
    var description: String
    var discountPercentage: Double?
    var expiryDate: String
    var minimumSpend: Double
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (
        lhs: Coupon,
        rhs: Coupon
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    
    init(id: String, code: String, couponType: String, description: String, discountPercentage: Double? = nil, expiryDate: String, minimumSpend: Double) {
        self.id = id
        self.code = code
        self.couponType = couponType
        self.description = description
        self.discountPercentage = discountPercentage
        self.expiryDate = expiryDate
        self.minimumSpend = minimumSpend
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case couponType
        case description
        case discountPercentage
        case expiryDate
        case minimumSpend
    }
}
