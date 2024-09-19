//
//  FindAllCategories.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

final class FindMealDetailUsecase {
    private var foodRepository : FoodRepository;
    
    init(foodRepository: FoodRepository) {
        self.foodRepository = foodRepository
    }
    
    func execute(dishId: String) async throws -> MealDetailListModel? {
        return try await self.foodRepository.findFoodById(id: dishId);
    }
}
