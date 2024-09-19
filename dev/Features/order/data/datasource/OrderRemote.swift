//
//  OrderRemote.swift
//  dev
//
//  Created by phan dam tung lam on 6/8/24.
//

import Foundation


protocol OrderDataSourceRemoteContract: DataSourceRemoteContract {
    func createOrder(dto: PayDto) async throws -> CommonResponse<OrderResponseModel>?;
    
    func cancelOrder(orderId: String) async throws -> CommonResponse<OrderResponseModel>?;
    
    func getOrder(orderId: String) async throws -> CommonResponse<OrderResponseModel>?;
    
    func getOrders() async throws -> CommonResponse<[OrderResponseModel]>?;
}

final class OrderDataSourceRemote : OrderDataSourceRemoteContract {
    private var networkContract: NetworkServiceContract;
    private var authenticationLocalStorage: AuthenticationLocalStorage;
    
    func getAuthorizationStorage() -> AuthenticationLocalStorage {
        return self.authenticationLocalStorage;
    }
    
    init(
        networkContract: NetworkServiceContract,
        authenticationLocalStorage: AuthenticationLocalStorage
    ) {
        self.networkContract = networkContract
        self.authenticationLocalStorage = authenticationLocalStorage
    }
    
    func createOrder(dto: PayDto) async throws -> CommonResponse<OrderResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.order,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<OrderResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: dto,
            method: "POST"
        );
    }
    
    func cancelOrder(orderId: String) async throws -> CommonResponse<OrderResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.replaceId(path:  NetworkUrlConstant.order, id: orderId) ,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<OrderResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "PUT"
        );
    }
    
    func getOrder(orderId: String) async throws -> CommonResponse<OrderResponseModel>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.replaceId(path:  NetworkUrlConstant.orderOne, id: orderId) ,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<OrderResponseModel>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "PUT"
        );
    }
    
    func getOrders() async throws -> CommonResponse<[OrderResponseModel]>? {
        let headers = formHeaders(customHeaders: nil)
        
        let formEndpoint = CustomEndpoint(
            path: NetworkUrlConstant.orderOne,
            headers: headers,
            queries: nil
        )
        return try await self.networkContract.fetchConcurrency(
            type: CommonResponse<[OrderResponseModel]>?.self,
            customUrl: formEndpoint.urlMain,
            headers: formEndpoint.headers,
            body: nil,
            method: "GET"
        );
    }
}
