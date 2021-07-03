//
//  HomeViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

enum RaffleFilter: String, CaseIterable {
    case none = "None"
    case recent = "Recent"
    case name = "Name"
}

final class HomeViewModel: ObservableObject {
    //MARK: - Properties
    @Published var raffleName: String
    @Published var secretToken: String
//    @Published var loadingState: LoadingState<[Raffle]> = .loading
    @Published var filteredRaffles: [Raffle]
    @Published var allRaffles: [Raffle] 
    @Published private(set) var isLoading: Bool
    @Published var alertMessage: AlertMessage?
//    @Published var currentRaffleId: Int?
    @Published private(set) var buttonDisabled: Bool
    @Published var filter: RaffleFilter
    
    private var getCancellable: AnyCancellable?
    private var postCancellable: AnyCancellable?
    var networkHelper: API
    
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
    init(
        raffleName: String = "",
        secretToken: String = "",
        filteredRaffles: [Raffle] = [],
        raffles: [Raffle] = [],
        isLoading: Bool = false,
        showAlert: Bool = false,
        alertMessage: AlertMessage? = nil,
        buttonDisabled: Bool = true,
        filter: RaffleFilter = .recent,
        api: API = RaffleAPIClient.shared
    ) {
        self.raffleName = raffleName
        self.secretToken = secretToken
        self.filteredRaffles = filteredRaffles
        self.allRaffles = raffles
        self.isLoading = isLoading
        self.alertMessage = alertMessage
        self.buttonDisabled = buttonDisabled
        self.filter = filter
        self.networkHelper = api
        
        allValidation
            .map(\.isSuccess)
            .map{!$0}
            .assign(to: &$buttonDisabled)
        
        $allRaffles
            .combineLatest($filter)
            .map { raffles, selectedFilter -> [Raffle] in
                switch selectedFilter {
                case .none:
                    return raffles
                case .recent:
                    return raffles.sorted { lhs, rhs in
                        lhs.createdAt > rhs.createdAt
                    }
                case .name:
                    return raffles.sorted { lhs, rhs in
                        lhs.name < rhs.name
                    }
                }
            }
            .assign(to: &$filteredRaffles)
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
        isLoading = true
    
        getCancellable = rafflesPublisher()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    if case .api(let response) = error {
                        self?.alertMessage = .failure(response.message)
                    } else {
                        self?.alertMessage = .failure(error.localizedDescription)
                    }
                }
                self?.isLoading = false
            })
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] raffles in
                self?.allRaffles = raffles
            })
    }
    
    func createRafflePublisher() -> CreateRafflePublisher {
        networkHelper
            .post(endpoint: .createRaffle,
                  params:
                    PostRaffle(
                        name: raffleName,
                        secretToken: secretToken
                    )
            )
            .eraseToAnyPublisher()
    }
    
    func rafflesPublisher() -> RafflesPublisher {
        networkHelper
            .get(endpoint: .allRaffles)
            .eraseToAnyPublisher()
    }
}
