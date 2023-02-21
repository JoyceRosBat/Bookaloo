//
//  UsersRepositoryProtocol.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

public protocol UsersRepositoryProtocol {
    func find(by email: String) async throws -> User
    func new(_ user: User) async throws -> EmptyResponse
    func modify(_ user: User) async throws -> EmptyResponse
    func markRead(_ readBooks: ReadBooks) async throws -> EmptyResponse
    func report(_ email: String) async throws -> Report
    func read(_ email: String) async throws -> Report
}
