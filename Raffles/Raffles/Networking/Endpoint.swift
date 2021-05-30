//
//  Endpoint.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import Foundation

enum Endpoint {
    case allRaffles
    case createRaffle
    case retrieve(id: Int)
    case participants(id: Int)
    case signUp(id: Int)
    case pickWinner(id: Int)
    case retrieveWinner(id: Int)
    
    func path() -> String {
        switch self {
        case .allRaffles, .createRaffle:
            return "api/raffles"
        case .retrieve(id: let id):
            return "api/raffles/\(id)"
        case .participants(id: let id), .signUp(id: let id):
            return "api/raffles/\(id)/participants"
        case .pickWinner(id: let id), .retrieveWinner(id: let id):
            return "api/raffles/\(id)/winner"
        }
    }
}
