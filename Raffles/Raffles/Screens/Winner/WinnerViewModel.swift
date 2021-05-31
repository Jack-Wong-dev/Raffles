//
//  WinnerViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class WinnerViewModel: ObservableObject {
    //MARK: - Properties
    private let id: Int
    
//    @Published var alertMessage: AlertMessage?
    @Published private(set) var winner: PickWinnerResponse?
    @Published private(set) var isLoading: Bool
    
    private var cancellable: AnyCancellable?
    
    //For the sake of Dependency Injection
    init(id: Int, isLoading: Bool = false) {
        self.id = id
        self.isLoading = false
        
        //Immediately fetch all raffles
        getWinner()
    }
}

//Mark: Network Calls
extension WinnerViewModel {
    typealias RafflesPublisher = AnyPublisher<PickWinnerResponse,APIError>
    
    func getWinner()  {
        cancellable = getWinnerPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    dump(error)
                }
            }, receiveValue: { [weak self] result in
                self?.winner = result
            })
    }
    
    
    private func getWinnerPublisher() -> RafflesPublisher {
        RaffleAPIClient
            .shared
            .get(endpoint: .retrieveWinner(id: id))
            .eraseToAnyPublisher()
    }
}

