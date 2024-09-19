//
//  FoodRepository.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

protocol FoodRepository {
    func findFoodById(id: String) async throws -> MealDetailListModel?
    func searchMealByName(name: String) async throws -> MealDetailListModel?
    func listAllMealCategory() -> AnyPublisher<CategoryFoodListModel?, Error>
    func findFoodByCategory(category: String) async throws -> MealListModel?
}
