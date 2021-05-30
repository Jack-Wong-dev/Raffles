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
    
    private var getCancellable: AnyCancellable?
    private var postCancellable: AnyCancellable?
    
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
    typealias CreateRafflePublisher = AnyPublisher<PostRaffleResponse,APIError>

    func createRaffle() {
        postCancellable = createRafflePublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    dump(error)
                }
            }, receiveValue: { response in
                print(response.success)
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
    
//    private func createRafflePublisher() -> CreateRafflePublisher {
//        print(raffleName, secretToken)
//        return RaffleAPIClient
//            .shared
//            .post(endpoint: .createRaffle,
//                  params: [
//                    "name" : raffleName,
//                    "secret_Token" : secretToken
//                  ]
//            )
//            .eraseToAnyPublisher()
//    }
    private func createRafflePublisher() -> CreateRafflePublisher {
        print(raffleName, secretToken)
        return RaffleAPIClient
            .shared
            .post(endpoint: .createRaffle,
                  params: PostRaffle(name: raffleName, secretToken: secretToken)
            )
            .eraseToAnyPublisher()
    }
    
    private func rafflesPublisher() -> RafflesPublisher {
        RaffleAPIClient
            .shared
            .get(endpoint: .allRaffles)
    }
}
