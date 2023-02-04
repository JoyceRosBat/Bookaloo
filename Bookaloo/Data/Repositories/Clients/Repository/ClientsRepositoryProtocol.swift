//
//  ClientsRepositoryProtocol.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

protocol ClientsRepositoryProtocol {
    func findClient(by email: String) async throws -> User
    func new(_ client: User) async throws
    func modify(_ client: User) async throws
}
