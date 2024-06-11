//
//  NetworkTestCase.swift
//  SeSACTestTests
//
//  Created by 김지연 on 12/13/23.
//

import XCTest
@testable import SeSACTest



final class NetworkTestCase: XCTestCase {
    
    var sut: NetworkManager!

    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // 비동기 테스트: expectation / fulfill / wait
    func testExample() throws {
        
        print("1")
        
        let promise = expectation(description: "Lotto Number Completion Handler")
        
        sut.fetchLotto { lotto in
            print("2")
            print(lotto.bnusNo, lotto.drwNoDate, lotto.drwtNo1)
            
            var testNumber = lotto.bnusNo
            
            XCTAssertLessThanOrEqual(testNumber, 45)
            XCTAssertGreaterThanOrEqual(testNumber, 1)
            
            promise.fulfill() // 정의해둔 expectation이 충족되는 시점에 호출해서 동작을 수행했음을 알려줌
            
        }
        wait(for: [promise], timeout: 5) // 비동기 작업을 기다림. 타임아웃 시간이 지나면 실패 간주.
        print("3")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
