//
//  SeSACTestTests.swift
//  SeSACTestTests
//
//  Created by 김지연 on 12/8/23.
//

import XCTest
@testable import SeSACTest

// LoginVC 내 valid 메서드
final class SeSACTestTests: XCTestCase {

    var sut: LoginViewController! // 시스템이 테스트를 하려는 대상(system under test)
    
    override func setUpWithError() throws {
        // 테스트 시작 전 값 세팅
        print(#function)
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // 테스트 이후 초기화 (nil)
        print(#function)
        sut = nil
    }
    
    // 테스트 하려는 목적을 메서드 이름에 명확하게 작성
    func testLoginViewController_ValidEmail_ReturnTrue() throws {
        print(#function)
        sut.emailTextField.text = "journey@test.com"
        XCTAssertTrue(sut.isValidEmail(), "@없거나 6글자 미만임")
    }
    // 테스트 결과가 성공이지만, 사실 실패 케이스를 테스트 한 것
    // 테스트 코드 로직 자체는 성공해야하는 것
    func testLoginViewController_ValidEmail_ReturnFalse() throws {
        print(#function)
        sut.emailTextField.text = "jour"
        XCTAssertFalse(sut.isValidEmail(), "@없거나 6글자 미만임") // 실패해야 성공
    }
    
    func testLoginViewController_ValidEmail_ReturnNil() throws {
        print(#function)
        sut.emailTextField = nil
        XCTAssertNil(sut.emailTextField, "Nil") // Nil이 리턴되어야 성공
    }


    func testPerformanceExample() throws { 
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
