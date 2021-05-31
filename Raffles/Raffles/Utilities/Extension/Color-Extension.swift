//
//  Color-Extension.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import SwiftUI

extension Color {
    static let background = Color("background")
    static let shadow = Color("shadow")
    static let lighting = Color("lighting")
    static let gradientStart = Color("GradientStart")
    static let gradientEnd = Color("GradientEnd")
    
    static func getSelectionColor(using screen: ScreenOption) -> Color {
        switch screen {
        case .register:
            return .orange
        case .participants:
            return .green
        case .winner:
            return .yellow
        }
    }
}
