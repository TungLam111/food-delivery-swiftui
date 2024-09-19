//
//  BasketItemModel.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

class PaymentCardResponseModel: Identifiable, Codable, Hashable {
    var id: String
    var userId : String
    var cardHolderName: String
    var cardNumber: String
    var cardType: String
    var expirationDate: String;
    var startDate: String;
    
    init(
        id: String,
        userId: String, 
        cardHolderName: String, 
        cardNumber: String, 
        cardType: String,
        expirationDate: String,
        startDate: String
    ) {
            self.id = id
            self.userId = userId
            self.cardHolderName = cardHolderName
            self.cardNumber = cardNumber
            self.cardType = cardType
            self.expirationDate = expirationDate
            self.startDate = startDate
        }
    
    static func ==(lhs: PaymentCardResponseModel, rhs: PaymentCardResponseModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case cardHolderName
        case cardNumber
        case cardType
        case expirationDate
        case startDate
    }
    
    
}

