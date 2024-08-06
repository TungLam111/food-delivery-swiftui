//
//  AddPaymentCardDto.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

final class AddPaymentCardDto : Encodable {
    var cardHolderName: String
    var cardNumber: String
    var cardType: String
    var expirationDate: String
    var startDate: String
    var issueNumber: String
    var billingAddressID: String
    
    init(cardHolderName: String, cardNumber: String, cardType: String, expirationDate: String, startDate: String,
         billingAddressID: String,
         issueNumber: String
    ) {
        self.cardHolderName = cardHolderName
        self.cardNumber = cardNumber
        self.cardType = cardType
        self.expirationDate = expirationDate
        self.startDate = startDate
        self.issueNumber = issueNumber
        self.billingAddressID = billingAddressID
    }
}
