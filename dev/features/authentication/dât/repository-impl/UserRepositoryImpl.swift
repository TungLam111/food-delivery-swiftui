//
//  UserRepositoryImpl.swift
//  dev
//
//  Created by phan dam tung lam on 25/7/24.
//

import Foundation

class UserRepositoryImpl : UserRepository {
    private var remoteDataSource: UserDataSourceRemoteContract;
    private var localDataSource: UserDataSourceLocalContract;
    
    init(remoteDataSource: UserDataSourceRemoteContract, localDataSource: UserDataSourceLocalContract) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func login(dto: LoginDto) async throws -> DataState<LoginDataResponse?> {
        do {
            let response = try await self.remoteDataSource.login(dto: dto)
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
    
    func signup(dto: CreateAccoutDto) async throws -> DataState<SignupDataResponse?> {
        do {
            let response = try await self.remoteDataSource.signup(dto: dto)
            
            if response?.hasError == true {
                return DataFailed(error: ErrorException(
                    errorCode: response?.errorCode,
                    message: response?.message
                ))
            }
            return DataSuccess(data: response?.appData);
        }  catch FetchConcurrencyError.apiError(let errorCode, let message) {
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

