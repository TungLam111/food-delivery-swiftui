//
//  UsecaseDependencyInjection.swift
//  dev
//
//  Created by phan dam tung lam on 14/7/24.
//

import Foundation

class UsecasesDependencyInjection {
    var repositoriesDI: RepositoriesDependencyInjection
    init(repositoriesDI: RepositoriesDependencyInjection) {
        self.repositoriesDI = repositoriesDI
    }
    
    private(set) lazy var  findFoodByCategory = FindFoodByCategoryUsecase(
        foodRepository: self.repositoriesDI.foodRepository
    );
    
    private(set) lazy var findAllCategories = FindAllCategoriesUsecase(
        foodRepository: self.repositoriesDI.foodRepository 
    );
    
    private(set) lazy var findMealDetail =  FindMealDetailUsecase(
        foodRepository: self.repositoriesDI.foodRepository   
    );
    
    private(set) lazy var searchMealsByName =  SearchByTextUsecase(
        foodRepository: self.repositoriesDI.foodRepository
    );
}
