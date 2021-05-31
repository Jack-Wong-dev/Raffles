//
//  PickAWinnerViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class PickAWinnerViewModel: ObservableObject {
    @Published var secretToken: String
    
    init(secretToken: String = "") {
        self.secretToken = secretToken
    }
}
