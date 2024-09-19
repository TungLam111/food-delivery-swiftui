//
//  BasketItemModel.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

struct OrderResponseModel: Codable, Hashable {
    let id: String
    let userId: String
    let orderCode: String
    let orderType: String
    let totalAmount: Double
    let quantity: Int
    let couponId: String?
    let status: String;
    let paymentCardId: String;
    let discountAmount: String?
    let note: String?
    let orderRatingId: String?
    let timeDelivery: String
    let timeComplete: String?
    let isCancel: Bool
    let cancelReason: String
    let shipFee: String
    let shipAddress: String
    let shipCoordinates: String?
    let locationId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case orderCode
        case orderType
        case totalAmount
        case quantity
        case couponId
        case status
        case paymentCardId
        case discountAmount
        case note
        case orderRatingId
        case timeDelivery
        case timeComplete
        case isCancel
        case cancelReason
        case shipFee
        case shipAddress
        case shipCoordinates
        case locationId
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.userId = try container.decode(String.self, forKey: .userId)
        self.orderCode = try container.decode(String.self, forKey: .orderCode)
        self.orderType = try container.decode(String.self, forKey: .orderType)
        self.totalAmount = try container.decode(Double.self, forKey: .totalAmount)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        self.couponId = try container.decodeIfPresent(String.self, forKey: .couponId)
        self.status = try container.decode(String.self, forKey: .status)
        self.paymentCardId = try container.decode(String.self, forKey: .paymentCardId)
        self.discountAmount = try container.decodeIfPresent(String.self, forKey: .discountAmount)
        self.note = try container.decodeIfPresent(String.self, forKey: .note)
        self.orderRatingId = try container.decodeIfPresent(String.self, forKey: .orderRatingId)
        self.timeDelivery = try container.decode(String.self, forKey: .timeDelivery)
        self.timeComplete = try container.decodeIfPresent(String.self, forKey: .timeComplete)
        self.isCancel = try container.decode(Bool.self, forKey: .isCancel)
        self.cancelReason = try container.decode(String.self, forKey: .cancelReason)
        self.shipFee = try container.decode(String.self, forKey: .shipFee)
        self.shipAddress = try container.decode(String.self, forKey: .shipAddress)
        self.shipCoordinates = try container.decodeIfPresent(String.self, forKey: .shipCoordinates)
        self.locationId = try container.decodeIfPresent(String.self, forKey: .locationId)


    }
}

