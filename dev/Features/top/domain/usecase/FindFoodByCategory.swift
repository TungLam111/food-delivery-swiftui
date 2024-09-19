//
//  usecase-1.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation

final class FindFoodByCategoryUsecase {
    private var foodRepository : FoodRepository;
    
    init(foodRepository: FoodRepository) {
        self.foodRepository = foodRepository
    }
    
    func execute(category: String) async throws -> MealListModel? {
        return try await self.foodRepository.findFoodByCategory(category: category);
    }
}
