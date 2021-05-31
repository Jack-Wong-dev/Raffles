//
//  RegisterViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class RegisterViewModel: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var phoneNumber: String
    
    init(
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        phoneNumber: String = ""
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    func reset() {
        firstName = .init()
        lastName = .init()
        email = .init()
        phoneNumber = .init()
    }
}
