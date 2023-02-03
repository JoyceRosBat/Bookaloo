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
    func resolve() -> LoginViewModel
    func loginView() -> LoginView
    func homeView() -> HomeView
}

extension LoginDependenciesResolver {
    func resolve() -> LoginUseCaseProtocol {
        LoginUseCase(dependencies: self)
    }
    
    func resolve() -> LoginViewModel {
        LoginViewModel(dependencies: self)
    }
    
    func loginView() -> LoginView {
        LoginView(dependencies: self, viewModel: resolve())
    }
}
