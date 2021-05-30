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
    @Published private(set) var isLoading: Bool
    @Published var alertMessage: String?
    
    private var getCancellable: AnyCancellable?
    private var postCancellable: AnyCancellable?
    
    //For the sake of Dependency Injection
    init(raffleName: String = "",
         secretToken: String = "",
         raffles: [Raffle] = [],
         isLoading: Bool = false,
         showAlert: Bool = false,
         alertMessage: String? = nil
    ) {
        self.raffleName = raffleName
        self.secretToken = secretToken
        self.allRaffles = raffles
        self.isLoading = isLoading
        self.alertMessage = alertMessage
        
        //Immediately fetch all raffles
        getRaffles()
    }
}

//Mark: Network Calls
extension HomeViewModel {
    typealias RafflesPublisher = AnyPublisher<[Raffle],APIError>
    typealias CreateRafflePublisher = AnyPublisher<PostRaffleResponse,APIError>

    func createRaffle() {
        isLoading = true
        
        postCancellable = createRafflePublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    dump(error)
                    self?.alertMessage = error.localizedDescription
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] response in
                if response.success {
                    self?.getRaffles()
                }
                self?.alertMessage = response.title
            })
    }
    
    func getRaffles()  {
        getCancellable = rafflesPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    dump(error)
                }
            }, receiveValue: { [weak self] receivedRaffles in
                self?.allRaffles = receivedRaffles
            })
    }
    
    private func createRafflePublisher() -> CreateRafflePublisher {
        print(raffleName, secretToken)
        return RaffleAPIClient
            .shared
            .post(endpoint: .createRaffle,
                  params:
                    PostRaffle(
                        name: raffleName,
                        secretToken: secretToken
                    )
            )
            .eraseToAnyPublisher()
    }
    
    private func rafflesPublisher() -> RafflesPublisher {
        RaffleAPIClient
            .shared
            .get(endpoint: .allRaffles)
    }
}
