//
//  BasketItemModel.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

// Request model for shopping basket
class AddCartItem: Identifiable, Codable {
    var mealId : String
    var price: Double
    var quantity: Int
    var topping: [String: Int]
    var mealName: String;
    var mealCategory: String;
    var mealImage: String;
    
    init(mealId: String, price: Double, quantity: Int, topping: [String : Int],
         mealName: String,
         mealCategory: String,
         mealImage: String
    ) {
        self.mealId = mealId
        self.price = price
        self.quantity = quantity
        self.topping = topping
        self.mealName = mealName
        self.mealImage = mealImage
        self.mealCategory = mealCategory
    }
    
    static func ==(lhs: AddCartItem, rhs: AddCartItem) -> Bool {
        return lhs.mealId == rhs.mealId
    }
    
    enum CodingKeys: String, CodingKey {
        case mealId
        case price
        case quantity
        case topping
        case mealImage
        case mealName
        case mealCategory
    }
}

// Request model for shopping basket
class UpdateBasketItem: Identifiable, Codable {
    var id: String
    var mealId : String
    var price: Double
    var quantity: Int
    var topping: [String: Int]
    var userId: String;
    var mealName: String;
    var mealCategory: String;
    var mealImage: String;
    
    init(id: String, mealId: String, price: Double, quantity: Int, topping: [String : Int]
         ,
         userId: String,
         mealName: String,
         mealCategory: String,
         mealImage: String
    ) {
        self.mealId = mealId
        self.price = price
        self.quantity = quantity
        self.topping = topping
        self.userId = userId
        self.id = id
        self.mealName = mealName
        self.mealImage = mealImage
        self.mealCategory = mealCategory
    }
    
    static func ==(lhs: UpdateBasketItem, rhs: UpdateBasketItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case mealId
        case price
        case quantity
        case topping
        case userId
        case id
        case mealImage
        case mealName
        case mealCategory
    }
}

struct BasketListResponse: Codable, Hashable {
    let results: [BasketItemResponse]?
    let foodPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case results
        case foodPrice
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decodeIfPresent([BasketItemResponse].self, forKey: .results) ?? []
        self.foodPrice = try container.decode(Double.self, forKey: .foodPrice)
    }
}


// Request model for shopping basket
class BasketItemResponse: Identifiable, Codable, Hashable, Equatable {
    var id: String
    var mealId : String
    var price: Double
    var quantity: Int
    var topping: [String: Int]
    var userId: String;
    var createdAt: String;
    var mealName: String;
    var mealCategory: String;
    var mealImage: String;
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: BasketItemResponse, rhs: BasketItemResponse) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case mealId
        case price
        case quantity
        case topping
        case userId
        case createdAt
        case mealImage
        case mealName
        case mealCategory
    }
}

class BasketPricingData: Codable {
    let foodPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case foodPrice
    }
    
    init(foodPrice: Double) {
        self.foodPrice = foodPrice
    }
}

