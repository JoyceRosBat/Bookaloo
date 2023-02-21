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
        let user = try await usersRepository?.find(by: "joyce.usertest@bookaloo.com")
        XCTAssert(user?.name == "Joyce")
    }
    
    func test_find_user_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await usersRepository?.find(by: "joyce.usertest@bookaloo.com")
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_new_user_with_sucess() async throws {
        let newUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
        let user = try await usersRepository?.new(newUser)
        XCTAssert(user != nil)
    }
    
    func test_new_user_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            let newUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
            _ = try await usersRepository?.new(newUser)
        } catch let error as MockError {
            XCTAssert(error.code == 400)
            XCTAssert(error.errorCode == "400")
        }
    }
    
    func test_modify_user_with_sucess() async throws {
        let modifyUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
        let user = try await usersRepository?.modify(modifyUser)
        XCTAssert(user != nil)
    }
    
    func test_modify_user_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            let modifyUser = User(email: "joyce@email.com", name: "Joyce", location: "Location test", role: .admin)
            _ = try await usersRepository?.modify(modifyUser)
        } catch let error as MockError {
            XCTAssert(error.code == 400)
            XCTAssert(error.errorCode == "400")
        }
    }

    func test_mark_books_read_with_sucess() async throws {
        let booksRead = ReadBooks(email: "joyce@email.com", books: [1,2,3])
        let user = try await usersRepository?.markRead(booksRead)
        XCTAssert(user != nil)
    }
    
    func test_mark_books_read_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            let booksRead = ReadBooks(email: "joyce@email.com", books: [1,2,3])
            _ = try await usersRepository?.markRead(booksRead)
        } catch let error as MockError {
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
    
    func test_user_read_books_with_sucess() async throws {
        let read = try await usersRepository?.read("joyce.admin@bookaloo.com")
        XCTAssert(read?.books?.isEmpty == false)
    }
    
    func test_user_read_books_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await usersRepository?.read("joyce.admin@bookaloo.com")
        } catch let error as MockError {
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
    
    func test_user_report_with_sucess() async throws {
        let report = try await usersRepository?.report("joyce.admin@bookaloo.com")
        XCTAssert(report?.ordered?.isEmpty == false)
        XCTAssert(report?.readed?.isEmpty == false)
    }
    
    func test_user_report_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await usersRepository?.report("joyce.admin@bookaloo.com")
        } catch let error as MockError {
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
}
