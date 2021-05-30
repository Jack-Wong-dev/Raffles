//
//  Participant.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

public struct Participant: Decodable {
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

//MARK: Computer Properties
extension Participant {
    var fullName: String {
        "\(firstname) \(lastname)".capitalized
    }
}

//MARK: Placeholder for preview
extension Participant {
    static let placeholder: Participant = .init(id: 1,
                                                raffleId: 8,
                                                firstname: "Alejandro",
                                                lastname: "Franco",
                                                email: "alejandrofranco@pursuit.org",
                                                phone: "12345678900", registeredAt: Date()
    )
}
