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
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    #warning("TODO: Add Path Components")
    func makeURL() -> URL {
        return baseURL
    }
}

//MARK: API Methods
extension RaffleAPIClient: API {
    //Generic network call
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        session
            .dataTaskPublisher(for: request)
            .retry(1)
            .mapError { _ in .noInternet }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    //If successful response
                    if case 200...299 = response.statusCode {
                        return Just(data)
                            .decode(type: T.self, decoder: JSONDecoder())
                            .mapError {.decodingError($0)}
                            .eraseToAnyPublisher()
                    }
                }
                
                //If all possible avenues are exhausted
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
