//
//  UsersDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol UsersDependenciesResolver {
    func resolve() -> UsersRepositoryProtocol
    func resolve() -> UsersUseCaseProtocol
    func resolve() -> UsersViewModel
    func resolve() -> UsersView
    func resolve() -> ModifyUserView
    func resolve() -> CreateUserView
}

extension UsersDependenciesResolver {
    func resolve() -> UsersUseCaseProtocol {
        UsersUseCase(dependencies: self)
    }
    
    func resolve() -> UsersViewModel {
        UsersViewModel(dependencies: self)
    }
    
    func resolve() -> UsersView {
        UsersView(dependencies: self)
    }
    
    func resolve() -> ModifyUserView {
        ModifyUserView()
    }
    
    func resolve() -> CreateUserView {
        CreateUserView()
    }
}
