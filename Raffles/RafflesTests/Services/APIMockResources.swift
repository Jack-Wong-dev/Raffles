//
//  APIMockResources.swift
//  RafflesTests
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation
import Combine

class MockAPI : API {    
    static public let shared = MockAPI()
    
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        
        return Just([Raffle(id: 0, name: "PS5", createdAt: Date(), raffledAt: Date(), winnerId: 888)] as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func get<T>(endpoint: Endpoint) -> AnyPublisher<T, APIError> where T : Decodable {
        
        return Just([Raffle(id: 0, name: "PS5", createdAt: Date(), raffledAt: Date(), winnerId: 888)] as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func post<T, E>(endpoint: Endpoint, params: E?) -> AnyPublisher<T, APIError> where T : Decodable, E : Encodable {
        
        return Just([Raffle(id: 0, name: "PS5", createdAt: Date(), raffledAt: Date(), winnerId: 888)] as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    func put<T, E>(endpoint: Endpoint, params: E?) -> AnyPublisher<T, APIError> where T : Decodable, E : Encodable {
        
        return Just([Raffle(id: 0, name: "PS5", createdAt: Date(), raffledAt: Date(), winnerId: 888)] as! T)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }

    init() {

    }
}
