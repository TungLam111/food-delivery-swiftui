//
//  BasketRepositoryImpl.swift
//  dev
//
//  Created by phan dam tung lam on 31/7/24.
//

import Foundation

class BasketRepositoryImpl : BasketRepository {
    
    private var remoteDataSource: BasketDataSourceRemoteContract;
    private var localDataSource: BasketDataSourceLocalContract;
    
    init(remoteDataSource: BasketDataSourceRemoteContract, localDataSource: BasketDataSourceLocalContract) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAll() async throws -> DataState<BasketListResponse?> {
        do {
            let response = try await self.remoteDataSource.getAll()
            if response?.hasError == true {
                return DataFailed(error: ErrorException(
                    errorCode: response?.errorCode,
                    message: response?.message
                ))
            }
            return DataSuccess(data: response?.appData);
        } catch FetchConcurrencyError.apiError(let errorCode, let message) {
            return DataFailed(error: ErrorException(
                errorCode: errorCode,
                message: message
            )
            );
        } catch FetchConcurrencyError.invalidURL {
            print("Invalid URL")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.networkError(let networkError) {
            print("Network error occurred: \(networkError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.decodingError(let decodingError) {
            print("Failed to decode response: \(decodingError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.invalidResponse {
            print("Invalid response from server")
            return DataFailed(error: ErrorException());
        } catch {
            print("An unexpected error occurred: \(error)")
            return DataFailed(error: ErrorException());
        }
    }
    
    func getOne(basketId: String) async throws -> DataState<BasketItemResponse?> {
        do {
            let response = try await self.remoteDataSource.getOne(basketId: basketId)
            if response?.hasError == true {
                return DataFailed(error: ErrorException(
                    errorCode: response?.errorCode,
                    message: response?.message
                ))
            }
            return DataSuccess(data: response?.appData);
        } catch FetchConcurrencyError.apiError(let errorCode, let message) {
            return DataFailed(error: ErrorException(
                errorCode: errorCode,
                message: message
            )
            );
        } catch FetchConcurrencyError.invalidURL {
            print("Invalid URL")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.networkError(let networkError) {
            print("Network error occurred: \(networkError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.decodingError(let decodingError) {
            print("Failed to decode response: \(decodingError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.invalidResponse {
            print("Invalid response from server")
            return DataFailed(error: ErrorException());
        } catch {
            print("An unexpected error occurred: \(error)")
            return DataFailed(error: ErrorException());
        }
    }
    
    func addBasket(basket: AddCartItem) async throws -> DataState<BasketItemResponse?> {
        do {
            let response = try await self.remoteDataSource.add(dto: basket)
            if response?.hasError == true {
                return DataFailed(error: ErrorException(
                    errorCode: response?.errorCode,
                    message: response?.message
                ))
            }
            return DataSuccess(data: response?.appData);
        } catch FetchConcurrencyError.apiError(let errorCode, let message) {
            return DataFailed(error: ErrorException(
                errorCode: errorCode,
                message: message
            )
            );
        } catch FetchConcurrencyError.invalidURL {
            print("Invalid URL")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.networkError(let networkError) {
            print("Network error occurred: \(networkError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.decodingError(let decodingError) {
            print("Failed to decode response: \(decodingError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.invalidResponse {
            print("Invalid response from server")
            return DataFailed(error: ErrorException());
        } catch {
            print("An unexpected error occurred: \(error)")
            return DataFailed(error: ErrorException());
        }
    }
    
    func removeBasket(basketId: String) async throws -> DataState<BasketItemResponse?> {
        do {
            let response = try await self.remoteDataSource.remove(basketId: basketId)
            if response?.hasError == true {
                return DataFailed(error: ErrorException(
                    errorCode: response?.errorCode,
                    message: response?.message
                ))
            }
            return DataSuccess(data: response?.appData);
        } catch FetchConcurrencyError.apiError(let errorCode, let message) {
            return DataFailed(error: ErrorException(
                errorCode: errorCode,
                message: message
            )
            );
        } catch FetchConcurrencyError.invalidURL {
            print("Invalid URL")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.networkError(let networkError) {
            print("Network error occurred: \(networkError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.decodingError(let decodingError) {
            print("Failed to decode response: \(decodingError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.invalidResponse {
            print("Invalid response from server")
            return DataFailed(error: ErrorException());
        } catch {
            print("An unexpected error occurred: \(error)")
            return DataFailed(error: ErrorException());
        }
    }
    
    func updateBasket(basket: UpdateBasketItem) async throws -> DataState<BasketItemResponse?> {
        do {
            let response = try await self.remoteDataSource.update(basketId: basket.id, dto: basket)
            if response?.hasError == true {
                return DataFailed(error: ErrorException(
                    errorCode: response?.errorCode,
                    message: response?.message
                ))
            }
            return DataSuccess(data: response?.appData);
        } catch FetchConcurrencyError.apiError(let errorCode, let message) {
            return DataFailed(error: ErrorException(
                errorCode: errorCode,
                message: message
            )
            );
        } catch FetchConcurrencyError.invalidURL {
            print("Invalid URL")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.networkError(let networkError) {
            print("Network error occurred: \(networkError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.decodingError(let decodingError) {
            print("Failed to decode response: \(decodingError)")
            return DataFailed(error: ErrorException());
        } catch FetchConcurrencyError.invalidResponse {
            print("Invalid response from server")
            return DataFailed(error: ErrorException());
        } catch {
            print("An unexpected error occurred: \(error)")
            return DataFailed(error: ErrorException());
        }
    }
}
