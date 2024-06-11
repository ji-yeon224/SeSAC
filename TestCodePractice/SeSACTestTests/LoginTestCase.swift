//
//  LoginTestCase.swift
//  SeSACTestTests
//
//  Created by 김지연 on 12/11/23.
//

import XCTest
@testable import SeSACTest

final class LoginTestCase: XCTestCase {
    
    
    var sut: Validator!
    let user = User(email: "journey@test.com", password: "123456", check: "123456")
    

    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testValidator_ValidEmail_ReturnTrue() throws {
        
        let valid = sut.isValidEmail(email: user.email)
        XCTAssertTrue(valid, "@ 없거나 6글자 미만임")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
