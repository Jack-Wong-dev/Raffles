import Foundation
import Combine

var greeting = "Hello, playground"

struct CreateRaffle: Encodable {
    let name: String
    let secretToken: String
}

var url = URL(string: "https://raffle-fs-app.herokuapp.com/api/raffles")!

var request = URLRequest(url: url)
request.httpMethod = "POST"
request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

let encoder = JSONEncoder()
encoder.keyEncodingStrategy = .convertToSnakeCase

let borat = CreateRaffle(name: "Borat", secretToken: "borat")
let encodedData = try? encoder.encode(borat)

print(String(data: encodedData!, encoding: .utf8)!)
request.httpBody = encodedData

var cancellable: AnyCancellable?

func makePostCall() {
    cancellable = URLSession
        .shared
        .dataTaskPublisher(for: request)
        .print()
        .receive(on: DispatchQueue.main)
        .sink { completion in
            print(completion)
        } receiveValue: { result in
            print(result)
        }
}

makePostCall()
