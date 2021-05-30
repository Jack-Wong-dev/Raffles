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

////MARK: API Methods
//extension RaffleAPIClient: API {
//    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
//      
//    }
//    
//    func get<T>() -> AnyPublisher<T, APIError> where T : Decodable {
//        <#code#>
//    }
//    
//    func post<T>() -> AnyPublisher<T, APIError> where T : Decodable {
//        <#code#>
//    }
//}
