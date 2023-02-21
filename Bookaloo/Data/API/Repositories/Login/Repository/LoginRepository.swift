//
//  LoginRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

public final class LoginRepository: LoginRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    public init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    public func validate(_ user: User) async throws -> User {
        let request = LoginRequest.validate(user)
        return try await networkRequester.doRequest(request: request)
    }
}
