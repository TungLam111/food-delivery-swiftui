//
//  BasketDataSourceRemoteContract.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

protocol BasketDataSourceRemoteContract: DataSourceRemoteContract {
    
    func add(dto: AddCartItem) async throws -> CommonResponse<BasketItemResponse>?;
    
    func remove(basketId: String) async throws -> CommonResponse<BasketItemResponse>?;
    
    func update(basketId: String, dto: UpdateBasketItem) async throws -> CommonResponse<BasketItemResponse>?;
    
    func getOne(basketId: String) async throws -> CommonResponse<BasketItemResponse>?;
    
    func getAll() async throws -> CommonResponse<BasketListResponse>?
}


final class BasketDataSourceRemote: BasketDataSourceRemoteContract {
    private var networkContract: NetworkServiceContract;
    private var authenticationLocalStorage: AuthenticationLocalStorage;
    
    init(networkContract: NetworkServiceContract, authenticationLocalStorage: AuthenticationLocalStorage) {
        self.networkContract = networkContract
        self.authenticationLocalStorage = authenticationLocalStorage
    }

    
    func remove(basketId: String) async throws -> CommonResponse<BasketItemResponse>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.deleteBasket.replacingOccurrences(of: "id", with: String(basketId)),
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<BasketItemResponse>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "DELETE"
        )
    }
    
    func update(basketId: String, dto: UpdateBasketItem) async throws -> CommonResponse<BasketItemResponse>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.updateOneBasket.replacingOccurrences(of: "id", with: String(basketId)),
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<BasketItemResponse>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto,
            method: "PUT"
        )
    }
    
    func getOne(basketId: String) async throws -> CommonResponse<BasketItemResponse>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.getOneBasket.replacingOccurrences(of: "id", with: String(basketId)),
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<BasketItemResponse>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        )
    }
    
    func getAll() async throws -> CommonResponse<BasketListResponse>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.basket,
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<BasketListResponse>?.self, customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        )
    }
    
    func add(dto: AddCartItem) async throws -> CommonResponse<BasketItemResponse>? {
        let headers = formHeaders(customHeaders: nil)
                
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.basket,
            headers: headers,
            queries: nil
        )
        
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<BasketItemResponse>?.self, customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto,
            method: "POST"
        )
    }
    
    func getAuthorizationStorage() -> AuthenticationLocalStorage {
        return self.authenticationLocalStorage;
    }
}

