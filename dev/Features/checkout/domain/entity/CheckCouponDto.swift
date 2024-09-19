//
//  AddPaymentCardDto.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

final class VerifyOrderDto : Encodable {
    var latitude: Double;
    var longitude: Double;
    var couponId: String?;
    var orderType: String;
    var paymentCardId: String?;
    var paymentMethodId: String?;
    var locationId: String?
    
    init(latitude: Double, longitude: Double, couponId: String? = nil, orderType: String, paymentCardId: String? = nil, paymentMethodId: String?, locationId: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.couponId = couponId
        self.orderType = orderType
        self.paymentCardId = paymentCardId
        self.paymentMethodId = paymentMethodId
        self.locationId = locationId
    }
}
