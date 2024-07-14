//
//  FoodModel.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation

struct MealListModel: Codable, Hashable {
    let meals: [MealModel]
}

class MealModel: Codable, Hashable, Equatable, Identifiable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    
    static func == (
        lhs: MealModel,
        rhs: MealModel
      ) -> Bool {
        lhs.hashValue == rhs.hashValue
      }

    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(strMeal)
           hasher.combine(strMealThumb)
           hasher.combine(idMeal)
       }
}
