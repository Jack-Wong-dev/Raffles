//
//  RegisterParticipantReponse.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation

public struct RegisterParticipantResponse: Decodable {
  let type: String
  let success: Bool
  let title: String
  let content: String
}
