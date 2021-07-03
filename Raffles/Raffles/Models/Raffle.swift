//
//  Raffle.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

public struct Raffle: Decodable {
  let id: Int
  let name: String
  let createdAt: Date
  let raffledAt: Date?
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
public extension Raffle {
    static let placeholder = Raffle(id: 0, name: "Placeholder Name", createdAt: .init(), raffledAt: nil, winnerId: 777)
}

//MARK: Computer Properties
public extension Raffle {
    var winner: String {
        guard let winningId = winnerId else { return "No One Yet" }
        return String(winningId)
    }
    
    var createdDate: String {
        createdAt.toString(.medium)
    }
    
    var raffleDate: String {
        guard let date = raffledAt else { return "Not raffled yet"}
        return date.toString(.medium)
    }
}
