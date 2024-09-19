//
//  PaymentRepository.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class OrderRepositoryImpl : OrderRepository {
    
    var remoteDataSource: OrderDataSourceRemoteContract;
    
    init(remoteDatasource: OrderDataSourceRemoteContract) {
        self.remoteDataSource = remoteDatasource
    }
    
    func getOrders() async throws -> DataState<[OrderResponseModel]?> {
        do {
            let response = try await self.remoteDataSource.getOrders()
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
    
    func getOrder(orderId: String) async throws -> DataState<OrderResponseModel?> {
        do {
            let response = try await self.remoteDataSource.getOrder(orderId: orderId)
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
    
    func cancelOrder(orderId: String) async throws -> DataState<OrderResponseModel?> {
        do {
            let response = try await self.remoteDataSource.cancelOrder(orderId: orderId)
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
    
    func createOrder(dto: PayDto) async throws -> DataState<OrderResponseModel?> {
        do {
            let response = try await self.remoteDataSource.createOrder(dto: dto)
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
