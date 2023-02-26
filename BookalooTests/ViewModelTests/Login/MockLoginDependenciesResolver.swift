//
//  MockLoginDependenciesResolver.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 25/2/23.
//

import Foundation
import Bookaloo

final class MockLoginDependenciesResolver: LoginDependenciesResolver {
    var networkDependenciesResolver = MockNetworkRequestDependenciesResolver()
    
    func resolve() -> LoginRepositoryProtocol {
        LoginRepository(dependencies: networkDependenciesResolver)
    }
    
    func resolve() -> LoginUseCaseProtocol {
        LoginUseCase(dependencies: self)
    }
    
    func resolve() -> LoginViewModel {
        LoginViewModel(dependencies: self)
    }
    
    func resolve() -> LoginHomeView {
        fatalError()
    }
    
    func resolve() -> LoginView {
        fatalError()
    }
    
    func resolve() -> HomeView {
        fatalError()
    }
    
    func resolve() -> CreateUserView {
        fatalError()
    }
    
    
}
