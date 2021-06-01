//
//  RafflesTests.swift
//  RafflesTests
//
//  Created by Jack Wong on 5/31/21.
//

import XCTest
import Combine
@testable import Raffles

class RafflesTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    var mockAPI: MockAPI!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        mockAPI = MockAPI.shared
        homeViewModel = HomeViewModel(api: mockAPI)
        cancellables = []
    }

    override func tearDown() {
        cancellables = []
    }
    
    func test_allRafflesReturnsResponse() {
        let raffles = [Raffle(id: 0, name: "PS5", createdAt: Date(), raffledAt: Date(), winnerId: 888)]
        
        let expectation = XCTestExpectation(description: "all raffles")
        
        _ = homeViewModel.rafflesPublisher().sink { completion in
            
        } receiveValue: { response in
            XCTAssertEqual(raffles.first?.name, response.first?.name)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
