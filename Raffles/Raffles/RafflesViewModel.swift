//
//  RafflesViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class RafflesViewModel: ObservableObject {
    typealias RafflesPublisher = AnyPublisher<[Raffle],APIError>
    
    //MARK: - Properties
    @Published private(set) var raffles: [Raffle] = []
    
    private var cancellable: AnyCancellable?
    
    init() {}
    
    //MARK: - Public Methods
    func getRaffles() {
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
                self?.raffles = receivedRaffles
            })
    }
    
    #warning("TODO: Specify Path Component here.")
    //MARK: - Private methods
    private func rafflesPublisher() -> RafflesPublisher {
        RaffleAPIClient.shared
            .get(endpoint: .allRaffles)
    }
}
