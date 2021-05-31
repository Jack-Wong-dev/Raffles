//
//  ValidationPublishers.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation
import Combine

class ValidationPublishers {
    typealias ValidationErrorClosure = () -> String
    typealias ValidationPublisher = AnyPublisher<Validation, Never>
    
    // Validates whether a string property is non-empty.
    static func nonEmptyValidation(for publisher: Published<String>.Publisher,
                                   errorMessage: @autoclosure @escaping ValidationErrorClosure, dropFirst: Bool) -> ValidationPublisher {
        return publisher.map { value in
            guard value.count > 0 else {
                return .failure(message: errorMessage())
            }
            return .success
        }
        .dropFirst(dropFirst ? 1 : 0) // If we are dealing with a non-empty form 
        .eraseToAnyPublisher()
    }
    
    #warning("TODO: Regex validation for email")
    static func regExValidation() {
        
    }
}

