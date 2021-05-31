//
//  Raffle.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

struct Raffle: Decodable {
  let id: Int
  let name: String
  let createdAt: Date
  let raffledAt: Date?
//    let createdAt: String
//    let raffledAt: String?
  let winnerId: Int?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case createdAt = "created_at"
    case raffledAt = "raffled_at"
    case winnerId = "winner_id"
  }
}

//MARK: Placeholder for Preview
extension Raffle {
    static let placeholder = Raffle(id: 0, name: "Johnny", createdAt: .init(), raffledAt: nil, winnerId: 11)
}

//MARK: Computer Properties
extension Raffle {
    var winner: String {
        guard let winningId = winnerId else { return "No One Yet" }
        return String(winningId)
    }
    
    var raffleDate: String {
        guard let date = raffledAt else { return "Not raffled yet"}
        return "\(date)"
    }
}
