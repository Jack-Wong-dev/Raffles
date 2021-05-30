//
//  RaffleAPIClient.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import Foundation
import Combine

#warning("TODO: REMOVE PLACEHOLDERS AND IMPLEMENT THE PROTOCOL STUBS.")
final class RaffleAPIClient {
    private let baseURL = URL(staticString: "https://raffle-fs-app.herokuapp.com")
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    #warning("TODO: Add Path Components")
    func makeURL() -> URL {
        return baseURL
    }
}

//MARK: API Methods
extension RaffleAPIClient: API {
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        session
            .dataTaskPublisher(for: request)
            .retry(1)
            .mapError { _ in .noInternet }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    #warning("TODO: Add GET")
    func get<T>() -> AnyPublisher<T, APIError> where T : Decodable {
        let urlRequest = URLRequest(url: makeURL())
        return request(urlRequest)
            .eraseToAnyPublisher()
    }

    #warning("TODO: Add POST")
    func post<T>() -> AnyPublisher<T, APIError> where T : Decodable {
        let urlRequest = URLRequest(url: makeURL())
        return request(urlRequest)
            .eraseToAnyPublisher()
    }
}
