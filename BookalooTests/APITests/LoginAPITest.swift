//
//  LoginAPITest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import XCTest
@testable import Bookaloo

final class LoginAPITest: XCTestCase {
    var mockDependenciesResolver = MockNetworkRequestDependenciesResolver()
    var loginRepository: LoginRepositoryProtocol?
    
    override func setUpWithError() throws {
        loginRepository = mockDependenciesResolver.resolve()
    }

    override func tearDownWithError() throws {
        loginRepository = nil
    }
    
    func test_login_with_sucess() async throws {
        // Given
        let validationUser = User(email: "joyce.usertest@bookaloo.com")
        // When
        let user = try await loginRepository?.validate(validationUser)
        // Then
        XCTAssert(user?.role == .admin)
    }
    
    func test_login_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            let validationUser = User(email: "joyce.usertest@bookaloo.com")
            _ = try await loginRepository?.validate(validationUser)
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
}
