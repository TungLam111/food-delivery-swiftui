//
//  Remote.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

protocol FoodDataSourceRemoteContract {
    func getAllCategories() -> AnyPublisher<CategoryFoodListModel?, Error>;
    func getFoodByCategory(by categoryName: String) -> AnyPublisher<MealListModel?, Error>;
    
    func getFoodByCategoryAsync(categoryName: String) async throws -> MealListModel?;
    func getMealDetail(dishId: String) async throws -> MealDetailListModel?;
    func searchMealsByName(by name: String) async throws -> MealDetailListModel?
}

final class FoodDataSourceRemote : FoodDataSourceRemoteContract {
    
    private var networkContract: NetworkServiceContract;
    
    init(networkContract: NetworkServiceContract) {
        self.networkContract = networkContract
    }
    
    func getAllCategories() -> AnyPublisher<CategoryFoodListModel?, Error> {
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.categoryUrl,
            headers: nil,
            queries: nil
        )
        return self.networkContract.fetch(
            type: CategoryFoodListModel?.self,
            url: formEndpoint.url,
            body: nil
        );
    }
    
    func getFoodByCategory(by categoryName: String) -> AnyPublisher<MealListModel?, Error> {
        var queries: [String: String] = [:]
        queries["c"] = categoryName
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.foodListFilterUrl,
            headers: nil,
            queries: queries
        )
        
        return self.networkContract.fetch(
            type: MealListModel?.self,
            url: formEndpoint.url,
            body: nil
        );
    }
    
    func getFoodByCategoryAsync(categoryName: String) async throws -> MealListModel? {
        var queries: [String: String] = [:]
        queries["c"] = categoryName
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.foodListFilterUrl,
            headers: nil,
            queries: queries
        )
        
        let data = try await self.networkContract.fetchConcurrency(type: MealListModel?.self, customUrl: formEndpoint.url, body: nil, method: "GET");
        return data;
    }
    
    func getMealDetail(dishId: String) async throws -> MealDetailListModel? {
        var queries: [String: String] = [:]
        queries["i"] = dishId
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.lookupFullMealDetailUrl,
            headers: nil,
            queries: queries
        )
        let data = try await self.networkContract.fetchConcurrency(
            type: MealDetailListModel?.self, customUrl: formEndpoint.url,
            body: nil,
            method: "GET"
        );
        return data;
    }
    
    func searchMealsByName(by name: String) async throws -> MealDetailListModel? {
        
        var queries: [String: String] = [:]
        queries["s"] = name
        
        let formEndpoint = CustomEndpoint(path: NetworkUrlConstant.searchFoodUrl,
                                    headers: nil,
        queries: queries
        )
        
        let data = try await self.networkContract.fetchConcurrency(
            type: MealDetailListModel?.self,
            customUrl: formEndpoint.url,
            body: nil,
            method: "GET"
        );
        return data;
        
    }
}
