//
//  NetworkService.swift
//  dev
//
//  Created by phan dam tung lam on 11/7/24.
//

import Foundation
import Combine

protocol NetworkServiceContract: AnyObject {
    typealias Headers = [String: String]
    
    func fetch<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
    
    func fetchConcurrency<T: Decodable>(type: T.Type, url: URL, headers: Headers) async throws -> T
}

final class NetworkService: NetworkServiceContract {
    func fetch<T: Decodable>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchConcurrency<T: Decodable>(type: T.Type, url: URL, headers: Headers) async throws -> T {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
