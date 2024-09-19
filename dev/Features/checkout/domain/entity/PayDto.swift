//
//  AddPaymentCardDto.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

final class PayDto : Encodable {
    var orderType: String // { ship, take_away, reserve }
    var couponId: String?
    var paymentCardId: String?
    var paymentMethodId: String
    var locationId: String?
    var shipAddress: String
    var longitude: Double?
    var latitude: Double?
    
    init(
        orderType: String,
        couponId: String?,
        paymentCardId: String?,
        paymentMethodId: String,
        locationId: String?,
        shipAddress: String,
        latitude: Double?,
        longitude: Double?
    ) {
        self.orderType = orderType
        self.couponId = couponId
        self.paymentCardId = paymentCardId
        self.paymentMethodId = paymentMethodId
        self.locationId = locationId
        self.shipAddress = shipAddress
        self.longitude = longitude
        self.latitude = latitude
    }
}
