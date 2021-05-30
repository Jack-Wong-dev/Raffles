//
//  HomeViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var raffleName: String
    @Published var secretToken: String
    @Published var allRaffles: [Raffle]
    
    init(raffleName: String = "",
         secretToken: String = "",
         raffles: [Raffle] = []
    ) {
        self.raffleName = raffleName
        self.secretToken = secretToken
        self.allRaffles = raffles
    }
}
