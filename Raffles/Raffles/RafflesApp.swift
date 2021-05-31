//
//  RafflesApp.swift
//  Raffles
//
//  Created by Jack Wong on 5/29/21.
//

import SwiftUI

@main
struct RafflesApp: App {
    var body: some Scene {
        WindowGroup {
//            HomeView()
//            RaffleView(viewModel: .init(id: 203))
//            PickAWinnerView(viewModel: .init(id: 211))
            WinnerView(viewModel: .init(id: 203))
//            RaffleParticipantsView(viewModel: .init(id: 8))
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
