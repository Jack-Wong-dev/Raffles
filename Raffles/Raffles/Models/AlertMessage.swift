//
//  AlertMessage.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation

enum AlertMessage: Identifiable {
    case success(title: String, content: String)
    case failure(String)
    
    var id: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        }
    }
}
