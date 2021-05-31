//
//  APIMockResources.swift
//  RafflesTests
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation
import Combine

class MockAPI : API {
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        return Just("Hello" as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func get<T>(endpoint: Endpoint, params: [String : String]?) -> AnyPublisher<T, APIError> where T : Decodable {
        return Just("Hello" as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func post<T, E>(endpoint: Endpoint, params: E?) -> AnyPublisher<T, APIError> where T : Decodable, E : Encodable {
        return Just("Hello" as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func put<T, E>(endpoint: Endpoint, params: E?) -> AnyPublisher<T, APIError> where T : Decodable, E : Encodable {
        return Just("Hello" as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    init() {

    }
}
