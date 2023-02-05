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
        return User(
            email: "joyce.rosbat@gmail.com",
            name: "Joyce Rosario Batista",
            role: .admin,
            token: "test.auth.token.bookaloo"
        )
    }
}
