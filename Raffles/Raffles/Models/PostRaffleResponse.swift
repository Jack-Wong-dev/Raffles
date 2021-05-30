//
//  PostRaffleResponse.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

public struct PostRaffleResponse: Decodable {
  let type: String
  let success: Bool
  let title: String
  let content: ContentWrapper
}

public struct ContentWrapper: Decodable {
  let id: Int
  let name: String
  let secretToken: String
  let createdAt: Date
  let raffledAt: Date?
  let winnerId: Int?

  private enum CodingKeys: String, CodingKey {
    case id
    case name
    case secretToken = "secret_token"
    case createdAt = "created_at"
    case raffledAt = "raffled_at"
    case winnerId = "winner_id"
  }
}
