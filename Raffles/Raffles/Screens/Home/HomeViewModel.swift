//
//  HomeViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    //MARK: - Properties
    @Published var raffleName: String
    @Published var secretToken: String
    @Published var allRaffles: [Raffle]
    
    private var cancellable: AnyCancellable?
    
    init(raffleName: String = "",
         secretToken: String = "",
         raffles: [Raffle] = []
    ) {
        self.raffleName = raffleName
        self.secretToken = secretToken
        self.allRaffles = raffles
        
        getRaffles()
    }
}

//Mark: Network Calls
extension HomeViewModel {
    typealias RafflesPublisher = AnyPublisher<[Raffle],APIError>

    func createRaffle() {
        
    }
    
    func getRaffles()  {
        cancellable = rafflesPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            }, receiveValue: { [weak self] receivedRaffles in
                #if DEBUG
                dump(receivedRaffles)
                #endif
                self?.allRaffles = receivedRaffles
            })
    }
    
    private func rafflesPublisher() -> RafflesPublisher {
        RaffleAPIClient
            .shared
            .get(endpoint: .allRaffles)
    }
}
