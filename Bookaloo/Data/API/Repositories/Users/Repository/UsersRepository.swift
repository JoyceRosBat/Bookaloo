//
//  UsersRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

final class UsersRepository: UsersRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    func find(by email: String) async throws -> User {
        let request = UsersRequest.find(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    func new(_ user: User) async throws -> EmptyResponse {
        let request = UsersRequest.new(user)
        return try await networkRequester.doRequest(request: request)
    }
    
    func modify(_ user: User) async throws -> EmptyResponse {
        let request = UsersRequest.modify(user)
        return try await networkRequester.doRequest(request: request)
    }
    
    func markRead(_ readBooks: ReadBooks) async throws -> EmptyResponse {
        let request = UsersRequest.markRead(readBooks)
        return try await networkRequester.doRequest(request: request)
    }
    
    func report(_ email: String) async throws -> Report {
        let request = UsersRequest.report(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    func read(_ email: String) async throws -> Report {
        let request = UsersRequest.read(email)
        return try await networkRequester.doRequest(request: request)
    }
}
