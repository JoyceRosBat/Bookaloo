//
//  LoginUseCase.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

protocol LoginUseCaseProtocol {
    func validate(_ user: User) async throws -> User
}

final class LoginUseCase: LoginUseCaseProtocol {
    let repository: LoginRepositoryProtocol
    
    init(dependencies: LoginDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    func validate(_ user: User) async throws -> User {
        try await repository.validate(user)
    }
}
