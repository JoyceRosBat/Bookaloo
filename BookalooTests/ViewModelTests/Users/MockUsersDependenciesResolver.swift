//
//  MockUsersDependenciesResolver.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import Foundation
import Bookaloo

final class MockUsersDependenciesResolver: UsersDependenciesResolver {
    var networkDependenciesResolver = MockNetworkRequestDependenciesResolver()
    
    func resolve() -> UsersRepositoryProtocol {
        UsersRepository(dependencies: networkDependenciesResolver)
    }
    
    func resolve() -> UsersUseCaseProtocol {
        UsersUseCase(dependencies: self)
    }
    
    func resolve() -> UsersViewModel {
        UsersViewModel(dependencies: self)
    }
    
    func resolve() -> UsersView {
        fatalError()
    }
    
    func resolve() -> ModifyUserView {
        fatalError()
    }
    
    func resolve() -> CreateUserView {
        fatalError()
    }
}
