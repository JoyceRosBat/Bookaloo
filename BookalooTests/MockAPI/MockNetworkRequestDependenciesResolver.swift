//
//  MockNetworkRequestDependenciesResolver.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import Foundation
import Bookaloo

final class MockNetworkRequestDependenciesResolver: NetworkRepositoryDependenciesResolver {
    var shouldFail: Bool = false
    var failError: Int = 500
    
    init(shouldFail: Bool = false, failError: Int = 500) {
        self.shouldFail = shouldFail
        self.failError = failError
    }
    
    func resolve() -> NetworkRequesterProtocol {
        MockNetworkClient(shouldFail: shouldFail, failError: failError)
    }
    
    func resolve() -> LoginRepositoryProtocol {
        LoginRepository(dependencies: self)
    }
    
    func resolve() -> BooksRepositoryProtocol {
        BooksRepository(dependencies: self)
    }
    
    func resolve() -> UsersRepositoryProtocol {
        UsersRepository(dependencies: self)
    }
    
    func resolve() -> ShopRepositoryProtocol {
        ShopRepository(dependencies: self)
    }
}
