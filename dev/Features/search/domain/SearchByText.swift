//
//  SearchByText.swift
//  dev
//
//  Created by phan dam tung lam on 15/7/24.
//

import Foundation

class SearchByTextUsecase {
    var foodRepository: FoodRepository
    
    init(foodRepository: FoodRepository) {
        self.foodRepository = foodRepository
    }
    
    func execute(text: String) async throws -> MealDetailListModel? {
        return try await self.foodRepository.searchMealByName(name: text);
    }
}
