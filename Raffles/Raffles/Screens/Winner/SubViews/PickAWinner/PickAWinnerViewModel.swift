//
//  PickAWinnerViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

public struct PickAWinnerRequest: Encodable {
    let id: Int
    let secretToken: String
}

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


//MARK: - Computer Properties
extension PickWinnerResponse {
    var fullName: String {
        "\(firstname) \(lastname)".capitalized
    }
    
    var registerdDate: String {
        registeredAt.toString(.medium)
    }
}

extension PickWinnerResponse {
    static let placeholder: PickWinnerResponse =
        .init(id: 200,
              raffleId: 203,
              firstname: "Daniela",
              lastname: "D",
              email: "Daniela@REVillage.com",
              phone: nil,
              registeredAt: Date()
        )
}

final class PickAWinnerViewModel: ObservableObject {
    let raffle: Raffle
    
    @Published var secretToken: String
    @Published var alertMessage: AlertMessage?
    @Published private(set) var isLoading: Bool
    var winner: PickWinnerResponse?
    
    private var cancellable: AnyCancellable?
    
    init(raffle: Raffle,
         secretToken: String = "",
         alertMessage: AlertMessage? = nil,
         isLoading: Bool = false
    ) {
        self.raffle = raffle
        self.secretToken = secretToken
        self.alertMessage = alertMessage
        self.isLoading = isLoading
    }
    
    func reset() {
        self.secretToken = .init()
    }
}

//MARK: Network methods
extension PickAWinnerViewModel {
    typealias WinnerPublisher = AnyPublisher<PickWinnerResponse, APIError>
    
    func pickWinner()  {
        isLoading = true
        
        cancellable = putWinnerPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    if case .api(let decoded) = error {
                        self?.alertMessage = .failure(decoded.message)
                    } else {
                        self?.alertMessage = .failure(error.localizedDescription)
                    }
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] response in
                self?.alertMessage = .success(title: "Winner!", content: "\(response.firstname) \(response.lastname)")
                self?.winner = response
            })
    }
    
    private func putWinnerPublisher() -> WinnerPublisher {
        RaffleAPIClient
            .shared
            .put(endpoint: .pickWinner(id: raffle.id),
                 params: PickAWinnerRequest(
                    id: raffle.id,
                    secretToken: secretToken
                 )
            )
            .eraseToAnyPublisher()
    }
}
