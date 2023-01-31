//
//  ClientsRepository.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

final class ClientsRepository: ClientsRepositoryProtocol {
    private let networkRequester = Requester()
    
    func findClient(by email: String) async throws -> Client {
        let request = ClientRequest.find(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    func new(_ client: Client) async throws {
        let request = ClientRequest.new(client)
        _ = try await networkRequester.doRequest(request: request)
    }
    
    func modify(_ client: Client) async throws {
        let request = ClientRequest.modify(client)
        _ = try await networkRequester.doRequest(request: request)
    }
}
