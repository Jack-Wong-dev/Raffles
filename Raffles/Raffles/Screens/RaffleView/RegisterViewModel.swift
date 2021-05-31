//
//  RegisterViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

final class RegisterViewModel: ObservableObject {
    let id: Int
    
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var phoneNumber: String
    
    @Published var alertMessage: AlertMessage?
    @Published private(set) var isLoading: Bool
    
    private var registerCancellable: AnyCancellable?
    
    init(
        id: Int,
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        phoneNumber: String = "",
        alertMessage: AlertMessage? = nil,
        isloading: Bool = false
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.alertMessage = alertMessage
        self.isLoading = isloading
    }
    
    func reset() {
        firstName = .init()
        lastName = .init()
        email = .init()
        phoneNumber = .init()
    }
}

//MARK: - Network Methods
extension RegisterViewModel {
    typealias RegisterPublisher = AnyPublisher<RegisterParticipantResponse,APIError>
    
    func register()  {
        isLoading = true
        
        registerCancellable = registerParticipantPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    #if DEBUG
                    print(error)
                    #endif
                    self?.alertMessage = .failure(error.localizedDescription)
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] response in
                #if DEBUG
                dump(response)
                #endif
                self?.alertMessage = .success(title: response.title, content: response.content)
            })
    }
    
    private func registerParticipantPublisher() -> RegisterPublisher {
        RaffleAPIClient
            .shared
            .post(endpoint: .signUp(id: id),
                  params: SignUpForm(
                    firstname: firstName,
                    lastname: lastName,
                    email: email,
                    phone: phoneNumber.isEmpty ? nil : phoneNumber)
            )
            .eraseToAnyPublisher()
    }
}
