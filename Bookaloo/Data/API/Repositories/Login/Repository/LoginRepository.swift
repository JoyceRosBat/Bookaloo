//
//  LoginRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

final class LoginRepository: LoginRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    func validate(_ user: User) async throws -> User {
        let request = LoginRequest.validate(user)
//        return try await networkRequester.doRequest(request: request)
        // Fake user response:
        let adminEmail: String = "joyce.admin@"
        let domain: String = "bookaloo.com"
        let role: Role
        if user.email == adminEmail + domain {
            role = .admin
        } else {
            role = .user
        }
        return User(
            email: user.email,
            name: "Joyce Rosario Batista",
            role: role,
            token: "test.auth.token.bookaloo"
        )
    }
}
