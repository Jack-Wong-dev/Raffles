//
//  HomeViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

enum AlertMessage: Identifiable {
    case success(title: String, content: String)
    case failure(String)
    
    var id: String {
        switch self {
        case .success:
            return "Success"
        case .failure:
            return "Failure"
        }
    }
}

final class HomeViewModel: ObservableObject {
    //MARK: - Properties
    @Published var raffleName: String
    @Published var secretToken: String
    @Published var allRaffles: [Raffle]
    @Published private(set) var isLoading: Bool
    @Published var alertMessage: AlertMessage?
    @Published var currentRaffleId: Int?
    @Published private(set) var buttonDisabled: Bool
    
    private var getCancellable: AnyCancellable?
    private var postCancellable: AnyCancellable?
//    private var bag: Set<AnyCancellable> = Set()
    
    //MARK: - Validation Publishers
    lazy var raffleNameValidation: ValidationPublisher = {
        $raffleName.nonEmptyValidator("Name must be provided")
    }()
    
    lazy var secretTokenValidation: ValidationPublisher = {
        $secretToken.nonEmptyValidator("Secret Token must be provided")
    }()
    
    lazy var allValidation: ValidationPublisher = {
        Publishers.CombineLatest(
            raffleNameValidation,
            secretTokenValidation
        ).map { v1, v2 in
            return [v1, v2].allSatisfy {
                $0.isSuccess } ? .success : .failure(message: "")
        }.eraseToAnyPublisher()
    }()
    
    //MARK:- Init For the sake of Dependency Injection
    init(raffleName: String = "",
         secretToken: String = "",
         raffles: [Raffle] = [],
         isLoading: Bool = false,
         showAlert: Bool = false,
         alertMessage: AlertMessage? = nil,
         buttonDisabled: Bool = true
    ) {
        self.raffleName = raffleName
        self.secretToken = secretToken
        self.allRaffles = raffles
        self.isLoading = isLoading
        self.alertMessage = alertMessage
        self.buttonDisabled = buttonDisabled
        
        allValidation
            .map(\.isSuccess)
            .map{!$0}
            .assign(to: &$buttonDisabled)
        
        //Immediately fetch all raffles
        getRaffles()
    }
    
    //MARK:- Methods
    func resetFields() {
        raffleName.removeAll()
        secretToken.removeAll()
    }
}

//Mark:- Network Calls
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
                    self?.alertMessage = .failure(error.localizedDescription)
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] response in
                if response.success {
                    self?.getRaffles()
                }
                self?.alertMessage = .success(title: response.title, content: "Created on: \(response.content.createdAt)")
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
            .eraseToAnyPublisher()
    }
}
