//
//  UsersRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

public final class UsersRepository: UsersRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    public init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    public func find(by email: String) async throws -> User {
        let request = UsersRequest.find(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    public func new(_ user: User) async throws -> EmptyResponse {
        let request = UsersRequest.new(user)
        return try await networkRequester.doRequest(request: request)
    }
    
    public func modify(_ user: User) async throws -> EmptyResponse {
        let request = UsersRequest.modify(user)
        return try await networkRequester.doRequest(request: request)
    }
    
    public func markRead(_ readBooks: ReadBooks) async throws -> EmptyResponse {
        let request = UsersRequest.markRead(readBooks)
        return try await networkRequester.doRequest(request: request)
    }
    
    public func report(_ email: String) async throws -> Report {
        if let report = Cache.shared.report {
            return report
        }
        let request = UsersRequest.report(email)
        let report: Report = try await networkRequester.doRequest(request: request)
        Cache.shared.report = report
        return report
    }
    
    public func read(_ email: String) async throws -> Report {
        let request = UsersRequest.read(email)
        return try await networkRequester.doRequest(request: request)
    }
}
