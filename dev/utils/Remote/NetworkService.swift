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
    typealias DynamicMappingData = [String: Any]
    
    func fetch<T>(
        type: T.Type,
        url: URL,
        body: Encodable?
    ) -> AnyPublisher<T, Error> where T: Decodable
    
    func fetchConcurrency<T: Decodable>(
        type: T.Type,
        customUrl: URL,
        headers: MappingData?,
        body: Encodable?,
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
        body: Encodable?
    ) -> AnyPublisher<T, Error> {
        
        var urlRequest = URLRequest(url: url)
        
        if (body != nil) {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: body! as Any, options: [])
                urlRequest.httpBody = jsonData
            } catch {
                return Fail(error: error).eraseToAnyPublisher()
            }
        }
        
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchConcurrency<T: Decodable>(
        type: T.Type,
        customUrl: URL,
        headers: MappingData?,
        body: Encodable?,
        method: String
    ) async throws -> T {
        var urlRequest = URLRequest(url: customUrl)
        urlRequest.httpMethod = method
        
        headers?.forEach({ (key: String, value: String) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        })
        
        if (body != nil) {
            let jsonData = try JSONEncoder().encode(body!)
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
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            return apiResponse;
        }
        
        if let commonResponse = apiResponse as? CommonResponse<BasketItemResponse>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            return apiResponse;
        }
        
        if let commonResponse = apiResponse as? CommonResponse<BasketListResponse>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            
            return apiResponse;
        }
        
        if let commonResponse = apiResponse as? CommonResponse<[LocationResponseModel]>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            
            return apiResponse;
        }
        
        
        if let commonResponse = apiResponse as? CommonResponse<[PaymentCardResponseModel]>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            
            return apiResponse;
        }
        
        if let commonResponse = apiResponse as? CommonResponse<[PaymentMethodResponseModel]>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            
            return apiResponse;
        }
        
        if let commonResponse = apiResponse as? CommonResponse<LocationResponseModel>
        {
            if commonResponse.hasError {
                throw FetchConcurrencyError.apiError(
                    errorCode: commonResponse.errorCode,
                    message: commonResponse.message
                )
            }
            
            return apiResponse;
        }
        
        return apiResponse
    }
}
