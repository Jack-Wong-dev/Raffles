//
//  Date-Extension.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation

public extension Date {
    func toString(_ style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: self)
    }
}
