//
//  RouterViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/31/21.
//

import Foundation
import Combine

final class RouterViewModel: ObservableObject {
    let raffle: Raffle
    
    @Published var screenOption: ScreenOption
    
    init(raffle: Raffle, screen: ScreenOption = .participants) {
        self.raffle = raffle
        self.screenOption = screen
    }
}
