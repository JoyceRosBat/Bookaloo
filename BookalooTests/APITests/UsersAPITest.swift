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
        let user = usersRepository?.find(by: "joyce.usertest@bookaloo.com")
        XCTAssert(user.name == "Joyce")
    }
}
