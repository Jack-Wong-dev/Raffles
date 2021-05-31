//
//  ParticipantsViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class ParticipantsViewModel: ObservableObject {
    let id: Int
    
    @Published private(set) var allParticipants: [Participant]
    private var getCancellable: AnyCancellable?
    
    init(id: Int, participants: [Participant] = []) {
        self.id = id
        self.allParticipants = participants
        
        getParticipants()
    }
}

//MARK: - Network Methods
extension ParticipantsViewModel {
    typealias ParticipantsPublisher = AnyPublisher<[Participant],APIError>
    
    func getParticipants() {
        getCancellable = getParticipantsPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    dump(error)
                }
            }, receiveValue: { [weak self] participants in
                self?.allParticipants = participants
            })
    }
    
    private func getParticipantsPublisher() -> ParticipantsPublisher {
        RaffleAPIClient
            .shared
            .get(endpoint: .participants(id: id))
            .eraseToAnyPublisher()
    }
}
