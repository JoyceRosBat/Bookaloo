//
//  ClientsRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

final class ClientsRepository: ClientsRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    func findClient(by email: String) async throws -> User {
        let request = ClientRequest.find(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    func new(_ client: User) async throws {
        let request = ClientRequest.new(client)
        _ = try await networkRequester.doRequest(request: request)
    }
    
    func modify(_ client: User) async throws {
        let request = ClientRequest.modify(client)
        _ = try await networkRequester.doRequest(request: request)
    }
    
    func markRead(_ readBooks: ReadBooks) async throws {
        let request = ClientRequest.markRead(readBooks)
        _ = try await networkRequester.doRequest(request: request)
    }
    
    func report(_ email: String) async throws -> Report {
        let request = ClientRequest.report(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    func read(_ email: String) async throws -> Report {
        let request = ClientRequest.read(email)
        return try await networkRequester.doRequest(request: request)
    }
}
