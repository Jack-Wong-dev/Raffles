//
//  SignUpForm.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

public struct SignUpForm: Encodable {
    let firstname: String
    let lastname: String
    let email: String
    let phone: String?
}
