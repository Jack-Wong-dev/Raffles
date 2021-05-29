//
//  API.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import Foundation
import Combine

protocol API {
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, Error> where T: Decodable

    func get<T>(path: PathComponent, params: [String:String]?) -> AnyPublisher<T, Error> where T: Decodable

    func post<T>(path: PathComponent) -> AnyPublisher<T, Error> where T: Decodable
}
