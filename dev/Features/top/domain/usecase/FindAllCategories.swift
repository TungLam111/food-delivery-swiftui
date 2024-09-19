//
//  FindAllCategories.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

final class FindAllCategoriesUsecase {
    private var foodRepository : FoodRepository;
    
    init(foodRepository: FoodRepository) {
        self.foodRepository = foodRepository
    }
    
    func execute() -> AnyPublisher<CategoryFoodListModel?, Error> {
        return self.foodRepository.listAllMealCategory()
    }
}
