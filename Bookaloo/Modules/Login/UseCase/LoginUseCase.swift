//
//  LoginUseCase.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

public protocol LoginUseCaseProtocol {
    func validate(_ user: User) async throws -> User
}

public final class LoginUseCase: LoginUseCaseProtocol {
    let repository: LoginRepositoryProtocol
    
    public init(dependencies: LoginDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    /// Validates if user and password are correct
    /// ```
    ///        loginUseCase.validate(user)
    /// ```
    public func validate(_ user: User) async throws -> User {
        try await repository.validate(user)
    }
}
