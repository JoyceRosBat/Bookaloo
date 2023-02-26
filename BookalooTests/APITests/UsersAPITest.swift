//
//  UsersAPITest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import XCTest
@testable import Bookaloo

final class UsersAPITest: XCTestCase {
    var mockDependenciesResolver = MockNetworkRequestDependenciesResolver()
    var usersRepository: UsersRepositoryProtocol?
    
    override func setUpWithError() throws {
        usersRepository = mockDependenciesResolver.resolve()
    }

    override func tearDownWithError() throws {
        usersRepository = nil
    }
    
    func test_find_user_with_sucess() async throws {
        // When
        let user = try await usersRepository?.find(by: "joyce.usertest@bookaloo.com")
        // Then
        XCTAssert(user?.name == "Joyce")
    }
    
    func test_find_user_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            _ = try await usersRepository?.find(by: "joyce.usertest@bookaloo.com")
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_new_user_with_sucess() async throws {
        // Given
        let newUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
        // When
        let user = try await usersRepository?.new(newUser)
        // Then
        XCTAssert(user != nil)
    }
    
    func test_new_user_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            let newUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
            _ = try await usersRepository?.new(newUser)
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 400)
            XCTAssert(error.errorCode == "400")
        }
    }
    
    func test_modify_user_with_sucess() async throws {
        // Given
        let modifyUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
        // When
        let user = try await usersRepository?.modify(modifyUser)
        // Then
        XCTAssert(user != nil)
    }
    
    func test_modify_user_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            let modifyUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
            _ = try await usersRepository?.modify(modifyUser)
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 400)
            XCTAssert(error.errorCode == "400")
        }
    }

    func test_mark_books_read_with_sucess() async throws {
        // Given
        let booksRead = ReadBooks(email: "joyce@email.com", books: [1,2,3])
        // When
        let user = try await usersRepository?.markRead(booksRead)
        // Then
        XCTAssert(user != nil)
    }
    
    func test_mark_books_read_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            let booksRead = ReadBooks(email: "joyce@email.com", books: [1,2,3])
            _ = try await usersRepository?.markRead(booksRead)
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
    
    func test_user_read_books_with_sucess() async throws {
        // When
        let read = try await usersRepository?.read("joyce.admin@bookaloo.com")
        // Then
        XCTAssert(read?.books?.isEmpty == false)
    }
    
    func test_user_read_books_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            _ = try await usersRepository?.read("joyce.admin@bookaloo.com")
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
    
    func test_user_report_with_sucess() async throws {
        // When
        let report = try await usersRepository?.report("joyce.admin@bookaloo.com")
        // Then
        XCTAssert(report?.ordered?.isEmpty == false)
        XCTAssert(report?.read?.isEmpty == false)
    }
    
    func test_user_report_should_fail() async throws {
        // Given
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            // When
            _ = try await usersRepository?.report("joyce.admin@bookaloo.com")
        } catch let error as MockError {
            // Then
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
}
