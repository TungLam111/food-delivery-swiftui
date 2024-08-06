//
//  BasketItemModel.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

struct PaymentMethodResponseModel: Codable, Hashable {
    let id: String
    let name: String
    let description: String
    let paymentMethodType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case paymentMethodType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.paymentMethodType = try container.decode(String.self, forKey: .paymentMethodType)
        self.id = try container.decode(String.self, forKey: .id)

    }
}

