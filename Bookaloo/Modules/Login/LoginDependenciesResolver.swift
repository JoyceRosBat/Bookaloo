//
//  LoginDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

protocol LoginDependenciesResolver {
    func resolve() -> LoginRepositoryProtocol
    func resolve() -> LoginUseCaseProtocol
    func loginViewModel() -> LoginViewModel
    func loginView() -> LoginView
    func loginScreenView() -> LoginScreenView
    func homeView() -> HomeView
}

extension LoginDependenciesResolver {
    func resolve() -> LoginUseCaseProtocol {
        LoginUseCase(dependencies: self)
    }
    
    func loginViewModel() -> LoginViewModel {
        LoginViewModel(dependencies: self)
    }
    
    func loginScreenView() -> LoginScreenView {
        LoginScreenView()
    }
    
    func loginView() -> LoginView {
        LoginView(dependencies: self)
    }
}
