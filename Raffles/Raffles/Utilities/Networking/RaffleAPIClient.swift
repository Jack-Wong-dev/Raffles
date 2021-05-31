//
//  RaffleAPIClient.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import Foundation
import Combine

final class RaffleAPIClient {
    static public let shared = RaffleAPIClient()
    
    private let baseURL = URL(staticString: "https://raffle-fs-app.herokuapp.com")
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func makeURL(endpoint: Endpoint) -> URL {
        var url = baseURL
        url = url.appendingPathComponent(endpoint.path())
        let component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        return component.url!
    }
    
    func makeRequest<E>(url: URL, httpMethod: HTTPMethod = .get, params: E? = nil, queryParamsAsBody: Bool = true) -> URLRequest where E: Encodable {
        var request: URLRequest
        request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        if let params = params {
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            
            let encodedData = try? encoder.encode(params)
            
            request.httpBody = encodedData
        }

        return request
    }
}

//MARK: API Methods
extension RaffleAPIClient: API {
    //Generic network call
    func request<T>(_ request: URLRequest) -> AnyPublisher<T, APIError> where T : Decodable {
        session
            .dataTaskPublisher(for: request)
            .mapError { _ in .noInternet }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    //If successful response
                    if case 200...299 = response.statusCode {
                        
                        let decoder = JSONDecoder()
                        let formatter = DateFormatter()
                        //Used for 'create_At' and 'raffled_At' Date properties
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        decoder.dateDecodingStrategy = .formatted(formatter)
                        
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError {.decodingError($0)}
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: .httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                
                //If all possible avenues are exhausted
                return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func get<T>(endpoint: Endpoint, params: [String:String]? = nil) -> AnyPublisher<T, APIError> where T : Decodable {
        let url = makeURL(endpoint: endpoint)
        let urlRequest = makeRequest(url: url, params: params)
        
        return request(urlRequest)
            .eraseToAnyPublisher()
    }
    
    func post<T, E>(endpoint: Endpoint, params: E? = nil) -> AnyPublisher<T, APIError> where T : Decodable, E : Encodable {
        let url = makeURL(endpoint: endpoint)
        let urlRequest = makeRequest(url: url, httpMethod: .post, params: params)
        
        return request(urlRequest)
            .eraseToAnyPublisher()
    }
    
    func put<T, E>(endpoint: Endpoint, params: E?) -> AnyPublisher<T, APIError> where T : Decodable, E : Encodable {
        let url = makeURL(endpoint: endpoint)
        let urlRequest = makeRequest(url: url, httpMethod: .put, params: params)
        
        return request(urlRequest)
            .eraseToAnyPublisher()
    }
}
