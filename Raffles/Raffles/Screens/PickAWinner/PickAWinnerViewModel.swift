//
//  PickAWinnerViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

public struct PickWinnerResponse: Decodable {
  let id: Int
  let raffleId: Int
  let firstname: String
  let lastname: String
  let email: String
  let phone: String?
  let registeredAt: Date

  private enum CodingKeys: String, CodingKey {
    case id
    case raffleId = "raffle_id"
    case firstname
    case lastname
    case email
    case phone
    case registeredAt = "registered_at"
  }
}

final class PickAWinnerViewModel: ObservableObject {
    @Published var secretToken: String
    
    init(secretToken: String = "") {
        self.secretToken = secretToken
    }
}

//MARK: Network methods
extension PickAWinnerViewModel {
    typealias WinnerPublisher = AnyPublisher<PickWinnerResponse, APIError>
    func pickWinner()  {
        
    }
    
//    private func winnerPublisher() -> WinnerPublisher {
//        RaffleAPIClient
//            .shared
//
//    }
}
