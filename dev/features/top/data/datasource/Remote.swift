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
    func getAllCategoriesAsync(categoryName: String) async throws -> MealListModel?;
    func getMealDetail(dishId: String) async throws -> MealDetailListModel?;
}

final class FoodDataSourceRemote : FoodDataSourceRemoteContract {
    private var networkContract: NetworkServiceContract;
    
    init(networkContract: NetworkServiceContract) {
        self.networkContract = networkContract
    }
    
    func getAllCategories() -> AnyPublisher<CategoryFoodListModel?, Error> {
        let formEndpoint = CustomEndpoint(path: NetworkUrlConstant.categoryUrl)
        return self.networkContract.fetch(
            type: CategoryFoodListModel?.self,
            url: formEndpoint.url,
            headers: formEndpoint.headers
        );
    }
    
    func getFoodByCategory(by categoryName: String) -> AnyPublisher<MealListModel?, Error> {
        let formEndpoint = CustomEndpoint(path: NetworkUrlConstant.foodListFilterUrl, queryItems: [
            URLQueryItem(name: "c", value: categoryName)
        ])
        return self.networkContract.fetch(type: MealListModel?.self, url: formEndpoint.url, headers: formEndpoint.headers);
    }
    
    func getAllCategoriesAsync(categoryName: String) async throws -> MealListModel? {
        let formEndpoint = CustomEndpoint(path: NetworkUrlConstant.foodListFilterUrl, queryItems: [
            URLQueryItem(name: "c", value: categoryName)
        ])
        let data = try await self.networkContract.fetchConcurrency(type: MealListModel?.self, url: formEndpoint.url, headers: formEndpoint.headers);
        return data;
    }
    
    func getMealDetail(dishId: String) async throws -> MealDetailListModel? {
        let formEndpoint = CustomEndpoint(path: NetworkUrlConstant.lookupFullMealDetailUrl, queryItems: [
            URLQueryItem(name: "i", value: dishId)
        ])
        let data = try await self.networkContract.fetchConcurrency(type: MealDetailListModel?.self, url: formEndpoint.url, headers: formEndpoint.headers);
        return data;
    }
}
