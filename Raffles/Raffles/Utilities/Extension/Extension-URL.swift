//
//  Extension-URL.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        self = url
    }
}
