//
//  ClientsRepositoryProtocol.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

protocol ClientsRepositoryProtocol {
    func findClient(by email: String) async throws -> Client
    func new(_ client: Client) async throws
    func modify(_ client: Client) async throws
}
