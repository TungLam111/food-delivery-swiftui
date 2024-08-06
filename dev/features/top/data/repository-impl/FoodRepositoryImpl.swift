//
//  FoodRepositoryImpl.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

class FoodRepositoryImpl : FoodRepository {
    
    private var remoteDataSource: FoodDataSourceRemoteContract;
    private var localDataSource: FoodDataSourceLocalContract;
    
    init(remoteDataSource: FoodDataSourceRemoteContract, localDataSource: FoodDataSourceLocalContract) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func searchMealByName(name: String) async throws -> MealDetailListModel? {
        do {
            let meals : MealDetailListModel? = try await self.remoteDataSource.searchMealsByName(by: name)
            return meals;
        } catch {
            print("Error fetching meals by category: \(error)")
            return nil;
        }
    }
    
    func listAllMealCategory() -> AnyPublisher<CategoryFoodListModel?, Error> {
        return self.remoteDataSource.getAllCategories()
    }
    
    func findFoodByCategory(category: String) async throws -> MealListModel? {
        do {
            print(category)
            let meals : MealListModel? = try await self.remoteDataSource.getFoodByCategoryAsync( categoryName: category)
            return meals;
        } catch {
            print("Error fetching foods: \(error)")
            return nil;
        }
    }
    
    func searchMealByName(name: String) {
        
    }
    
    func findFoodById(id: String) async throws -> MealDetailListModel? {
        do {
            let meals : MealDetailListModel? = try await self.remoteDataSource.getMealDetail(dishId: id)
            return meals;
        } catch {
            print("Error fetching food: \(error)")
            return nil;
        }
    }
}
