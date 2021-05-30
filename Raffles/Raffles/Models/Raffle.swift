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
//  let createdAt: Date
//  let raffledAt: Date?
    let createdAt: String
    let raffledAt: String?
  let winnerId: Int?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case createdAt = "created_at"
    case raffledAt = "raffled_at"
    case winnerId = "winner_id"
  }
}
