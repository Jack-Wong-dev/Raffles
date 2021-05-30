//
//  APIError.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

enum APIError: Error {
    case decodingError(Error)
    case httpError(Int)
    case noInternet
    case unknown
}
