//
//  BasketItemModel.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

// Request model for shopping basket
class PayCompleteResponseModel: Identifiable, Codable, Hashable {
    var id: String;
    
    init(id: String) {
        self.id = id
    }
    
    static func ==(lhs: PayCompleteResponseModel, rhs: PayCompleteResponseModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
       
    }
}
