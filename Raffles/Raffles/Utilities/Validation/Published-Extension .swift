//
//  Published-Extension .swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation
import Combine

extension Published.Publisher where Value == String {
    func nonEmptyValidator(_ errorMessage: @autoclosure @escaping ValidationErrorClosure, dropFirst: Bool = true) -> ValidationPublisher {
        return ValidationPublishers.nonEmptyValidation(for: self, errorMessage: errorMessage(), dropFirst: dropFirst)
    }
}
