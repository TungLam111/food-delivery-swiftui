//
//  PaymentRepository.swift
//  dev
//
//  Created by phan dam tung lam on 4/8/24.
//

import Foundation

class PaymentRepositoryImpl : PaymentRepository {
    func addLocation(dto: AddLocationDto) async throws -> DataState<LocationResponseModel?> {
        do {
            let response = try await self.remoteDataSource.addLocation(dto: dto)
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
    
    func getLocations() async throws -> DataState<[LocationResponseModel]?> {
        do {
            let response = try await self.remoteDataSource.getLocations()
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
    
    var remoteDataSource: PaymentDataSourceRemoteContract;
    
    init(remoteDatasource: PaymentDataSourceRemoteContract) {
        self.remoteDataSource = remoteDatasource
    }
    
    func getPaymentMethods() async throws -> DataState<[PaymentMethodResponseModel]?> {
        do {
            let response = try await self.remoteDataSource.getPaymentMethods()
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
    
    func getPaymentCards() async throws -> DataState<[PaymentCardResponseModel]?> {
        do {
            let response = try await self.remoteDataSource.getPaymentCards()
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
    
    func addPaymentCard(dto: AddPaymentCardDto) async throws -> DataState<PaymentCardResponseModel?> {
        do {
            let response = try await self.remoteDataSource.addPaymentCard (dto: dto)
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
    
    func pay(dto: PayDto) async throws -> DataState<PayCompleteResponseModel?> {
        do {
            let response = try await self.remoteDataSource.pay(dto: dto)
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
    
    func removePaymentCard(cardId: String) async throws -> DataState<PaymentCardResponseModel?> {
        do {
            let response = try await self.remoteDataSource.removePaymentCard(cardId: cardId)
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
