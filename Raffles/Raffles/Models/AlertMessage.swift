//
//  AlertMessage.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation

public enum AlertMessage: Identifiable {
    case success(title: String, content: String)
    case failure(String)
    
    public var id: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        }
    }
}
