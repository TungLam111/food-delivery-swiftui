//
//  NetworkService.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

class CommonResponse<T: Decodable>: Decodable {
    var hasError: Bool
    var errorCode: String
    var message: String
    var appData: T?
    
    init(hasError: Bool, errorCode: String, message: String, appData: T?) {
        self.hasError = hasError
        self.errorCode = errorCode
        self.message = message
        self.appData = appData
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hasError = (try? container.decode(Bool.self, forKey: .hasError)) ?? false
        self.errorCode = (try? container.decode(String.self, forKey: .errorCode)) ?? ""
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        self.appData = try? container.decode(T.self, forKey: .appData)
    }
    
    enum CodingKeys: String, CodingKey {
        case hasError
        case errorCode
        case message
        case appData
    }
}


protocol NetworkServiceContract: AnyObject {
    typealias MappingData = [String: String]
    
    func fetch<T>(
        type: T.Type,
        url: URL,
        body: MappingData?
    ) -> AnyPublisher<T, Error> where T: Decodable
    
    func fetchConcurrency<T: Decodable>(
        type: T.Type,
        customUrl: URL,
        body: MappingData?,
        method: String
    ) async throws -> T
}

// Define custom errors
enum FetchConcurrencyError: Error {
    case invalidURL
    case networkError(Error)
    case apiError(errorCode: String, message: String)
    case decodingError(Error)
    case invalidResponse
}

final class NetworkService: NetworkServiceContract {
    func fetch<T: Decodable>(
        type: T.Type,
        url: URL,
        body: MappingData?
    ) -> AnyPublisher<T, Error> {
        
        var urlRequest = URLRequest(url: url)
        
        if (body != nil) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body as Any, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }        }
        
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchConcurrency<T: Decodable>(
        type: T.Type,
        customUrl: URL,
        body: MappingData?,
        method: String
    ) async throws -> T {
        var urlRequest = URLRequest(url: customUrl)
        urlRequest.httpMethod = method
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
      if (body != nil) {
            let jsonData = try JSONEncoder().encode(body)
            urlRequest.httpBody = jsonData
        }
                
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
           
        let apiResponse = try JSONDecoder().decode(type, from: data)
        
        if let commonResponse = apiResponse as? CommonResponse<LoginDataResponse>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(errorCode: commonResponse.errorCode, message: commonResponse.message)
            }
            return apiResponse;
        }
        
        if let commonResponse = apiResponse as? CommonResponse<SignupDataResponse>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(errorCode: commonResponse.errorCode, message: commonResponse.message)
            }
            return apiResponse;
        }
        
        return apiResponse
        
    }
}
