//
//  UsersUseCase.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol UsersUseCaseProtocol {
    func find(by email: String) async throws -> User
    func new(_ user: User) async throws
    func modify(_ user: User) async throws
    func markRead(_ readBooks: ReadBooks) async throws
    func report(_ email: String) async throws -> Report
    func read(_ email: String) async throws -> Report
}

final class UsersUseCase: UsersUseCaseProtocol {
    private let repository: UsersRepositoryProtocol
    
    init(dependencies: UsersDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    /// Finds a user by email
    /// ```
    ///        usersUseCase.find(by: email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to find
    func find(by email: String) async throws -> User {
        try await repository.find(by: email)
    }
    
    /// Creates a new user
    /// ```
    ///        usersUseCase.new(user)
    /// ```
    /// - Parameters:
    ///   - user: User to create
    func new(_ user: User) async throws {
        _ = try await repository.new(user)
    }
    
    /// Modify a user
    /// ```
    ///        usersUseCase.modify(user)
    /// ```
    /// - Parameters:
    ///   - user: User to modify
    func modify(_ user: User) async throws {
        _ = try await repository.modify(user)
    }
    
    /// Mark books as read
    /// ```
    ///        usersUseCase.markRead(readBooks)
    /// ```
    /// - Parameters:
    ///   - readBooks: Books to mark as read
    func markRead(_ readBooks: ReadBooks) async throws {
        _ = try await repository.markRead(readBooks)
    }
    
    /// Get books read and purchased of a user by email
    /// ```
    ///        usersUseCase.report(email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to get the list of books
    func report(_ email: String) async throws -> Report {
        if let report = Cache.shared.report {
            return report
        }
        let report = try await repository.report(email)
        Cache.shared.report = report
        return report
    }
    
    /// Get books read of a user by email
    /// ```
    ///        usersUseCase.report(email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to get the list of books
    func read(_ email: String) async throws -> Report {
        try await repository.read(email)
    }
}
