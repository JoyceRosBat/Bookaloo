//
//  LoginDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

public protocol LoginDependenciesResolver {
    func resolve() -> LoginRepositoryProtocol
    func resolve() -> LoginUseCaseProtocol
    func resolve() -> LoginViewModel
    func resolve() -> LoginHomeView
    func resolve() -> LoginView
    func resolve() -> HomeView
    func resolve() -> CreateUserView
}

extension LoginDependenciesResolver {
    func resolve() -> LoginUseCaseProtocol {
        LoginUseCase(dependencies: self)
    }
    
    func resolve() -> LoginViewModel {
        LoginViewModel(dependencies: self)
    }
    
    func resolve() -> LoginHomeView {
        LoginHomeView(dependencies: self)
    }
    
    func resolve() -> LoginView {
        LoginView(dependencies: self)
    }
}
