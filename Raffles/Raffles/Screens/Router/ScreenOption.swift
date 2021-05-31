//
//  ScreenOption.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation

enum ScreenOption: String, CaseIterable {
    case register = "register"
    case participants = "participants"
    case winner = "winner"
}

extension ScreenOption {
    var systemName: String {
        switch self {
        case .register:
            return "square.and.pencil"
        case .participants:
            return "person.3.fill"
        case .winner:
            return "crown.fill"
        }
    }
}
