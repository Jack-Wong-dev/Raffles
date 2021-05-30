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
    static let baseURL = URL(staticString: "https://raffle-fs-app.herokuapp.com")
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    #warning("TODO: Add Path Components")
    static func makeURL() -> URL {
        return baseURL
    }
}

//extension RaffleAPIClient: API {
//    //MARK: API Methods
//    func request<T>(_ request: URLRequest) -> AnyPublisher<T, Error> where T : Decodable {
//    }
//
//    func get<T>() -> AnyPublisher<T, Error> where T : Decodable {
//
//    }
//
//    func post<T>() -> AnyPublisher<T, Error> where T : Decodable {
//
//    }
//}
