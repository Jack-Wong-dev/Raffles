//
//  RegisterViewModel.swift
//  Raffles
//
//  Created by Jack Wong on 5/30/21.
//

import Foundation
import Combine

struct SignUpForm: Encodable {
    let firstname: String
    let lastname: String
    let email: String
    let phone: String?
}

final class RegisterViewModel: ObservableObject {
    let id: Int
    
    @Published var firstName: String
    @Published var lastName: String
    @Published var email: String
    @Published var phoneNumber: String
    
    private var registerCancellable: AnyCancellable?
    
    init(
        id: Int,
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        phoneNumber: String = ""
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
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
        registerCancellable = registerParticipantPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    #if DEBUG
                    print(error)
                    #endif
                }
            }, receiveValue: { response in
                #if DEBUG
                dump(response)
                #endif
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
