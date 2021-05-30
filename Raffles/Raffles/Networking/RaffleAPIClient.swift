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
    static public let shared = RaffleAPIClient()
    
    private let baseURL = URL(staticString: "https://raffle-fs-app.herokuapp.com")
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    #warning("TODO: Add Path Components")
    func makeURL(endpoint: Endpoint, isJSONAPI: Bool) -> URL {
           var url = baseURL
           url = url.appendingPathComponent(endpoint.path())
           if isJSONAPI {
               url = url.appendingPathExtension("json")
           }
           let component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
           return component.url!
       }
    
    func makeRequest(url: URL, httpMethod: String = "GET", params: [String:String]? = nil, queryParamsAsBody: Bool = false) -> URLRequest {
        var request: URLRequest
             var url = url
             if let params = params {
                 if queryParamsAsBody {
                     var urlComponents = URLComponents()
                     urlComponents.queryItems = []
                     for (_, param) in params.enumerated() {
                         urlComponents.queryItems?.append(URLQueryItem(name: param.key, value: param.value))
                     }
                     request = URLRequest(url: url)
                     request.httpBody = urlComponents.percentEncodedQuery?.data(using: .utf8)
                     request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
                 } else {
                     for (_, value) in params.enumerated() {
                         url = url.appending(value.key, value: value.value)
                     }
                     request = URLRequest(url: url)
                 }
             } else {
                 request = URLRequest(url: url)
             }
             request.httpMethod = httpMethod
             return request
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
                        let decoder = JSONDecoder()
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        decoder.dateDecodingStrategy = .formatted(formatter)
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
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

    func get<T>(endpoint: Endpoint, params: [String:String]? = nil) -> AnyPublisher<T, APIError> where T : Decodable {
        let url = makeURL(endpoint: endpoint, isJSONAPI: false)
        let urlRequest = makeRequest(url: url, params: params)
        return request(urlRequest)
            .eraseToAnyPublisher()
    }

    func post<T>(endpoint: Endpoint, params: [String:String]? = nil) -> AnyPublisher<T, APIError> where T : Decodable {
        let url = makeURL(endpoint: endpoint, isJSONAPI: true)
        let urlRequest = makeRequest(url: url, httpMethod: "POST", params: params, queryParamsAsBody: true)
        return request(urlRequest)
            .eraseToAnyPublisher()
    }
}
