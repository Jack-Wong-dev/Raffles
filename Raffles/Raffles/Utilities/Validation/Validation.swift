//
//  Validation.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

enum Validation {
    case success
    case notSet
    case failure(message: String)
    
    var isSuccess: Bool {
        if case .success = self{
            return true
        }
        return false
    }
}
