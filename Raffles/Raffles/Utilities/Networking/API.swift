//
//  API.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import Foundation
import Combine

protocol API {
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T: Decodable

    func get<T>(endpoint: Endpoint, params: [String:String]?) -> AnyPublisher<T, APIError> where T: Decodable

    func post<T, E>(endpoint: Endpoint, params: E?) -> AnyPublisher<T, APIError> where T: Decodable, E: Encodable
}
