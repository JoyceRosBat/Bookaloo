//
//  LoginViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 25/2/23.
//

import XCTest
@testable import Bookaloo

@MainActor
final class LoginViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockLoginDependenciesResolver()
    var viewModel: LoginViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_validate_with_empty_data_should_fail() {
        // Given
        viewModel?.email = ""
        viewModel?.password = ""
        // When
        viewModel?.doLogin()
        // Then
        XCTAssert(viewModel?.validEmail == false)
        XCTAssert(viewModel?.validPassword == false)
        wait(self.viewModel?.myUserToModify.email == "")
    }
    
    func test_validate_with_empty_email_should_fail() {
        // Given
        viewModel?.email = ""
        viewModel?.password = "12345678"
        // When
        viewModel?.doLogin()
        // Then
        XCTAssert(viewModel?.validEmail == false)
        XCTAssert(viewModel?.validPassword == true)
        wait(self.viewModel?.myUserToModify.email == "")
    }
    
    func test_validate_with_empty_password_should_fail() {
        // Given
        viewModel?.email = "email@example.com"
        viewModel?.password = ""
        // When
        viewModel?.doLogin()
        // Then
        XCTAssert(viewModel?.validEmail == true)
        XCTAssert(viewModel?.validPassword == false)
        wait(self.viewModel?.myUserToModify.email == "")
    }
    
    func test_validate_with_success() {
        // Given
        viewModel?.email = "email@example.com"
        viewModel?.password = "12345678"
        // When
        viewModel?.doLogin()
        // Then
        XCTAssert(viewModel?.validEmail == true)
        XCTAssert(viewModel?.validPassword == true)
        wait(self.viewModel?.myUserToModify.email == "joyce.admin@bookaloo.com")
    }
    
    func test_validate_should_fail() {
        // Given
        mockDependenciesResolver.networkDependenciesResolver.shouldFail = true
        viewModel?.email = "email@example.com"
        viewModel?.password = "12345678"
        // When
        viewModel?.doLogin()
        // Then
        XCTAssert(viewModel?.validEmail == true)
        XCTAssert(viewModel?.validPassword == true)
        wait(self.viewModel?.myUserToModify.email == "")
    }
}
