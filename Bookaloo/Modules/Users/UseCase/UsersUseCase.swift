//
//  UsersUseCase.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

public protocol UsersUseCaseProtocol {
    func find(by email: String) async throws -> User
    func new(_ user: User) async throws
    func modify(_ user: User) async throws
    func markRead(_ readBooks: ReadBooks) async throws
    func report(_ email: String) async throws -> Report
    func read(_ email: String) async throws -> Report
}

public final class UsersUseCase: UsersUseCaseProtocol {
    private let repository: UsersRepositoryProtocol
    
    public init(dependencies: UsersDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    /// Finds a user by email
    /// ```
    ///        usersUseCase.find(by: email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to find
    public func find(by email: String) async throws -> User {
        try await repository.find(by: email)
    }
    
    /// Creates a new user
    /// ```
    ///        usersUseCase.new(user)
    /// ```
    /// - Parameters:
    ///   - user: User to create
    public func new(_ user: User) async throws {
        _ = try await repository.new(user)
    }
    
    /// Modify a user
    /// ```
    ///        usersUseCase.modify(user)
    /// ```
    /// - Parameters:
    ///   - user: User to modify
    public func modify(_ user: User) async throws {
        _ = try await repository.modify(user)
    }
    
    /// Mark books as read
    /// ```
    ///        usersUseCase.markRead(readBooks)
    /// ```
    /// - Parameters:
    ///   - readBooks: Books to mark as read
    public func markRead(_ readBooks: ReadBooks) async throws {
        _ = try await repository.markRead(readBooks)
    }
    
    /// Get books read and purchased of a user by email
    /// ```
    ///        usersUseCase.report(email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to get the list of books
    public func report(_ email: String) async throws -> Report {
        return try await repository.report(email)
    }
    
    /// Get books read of a user by email
    /// ```
    ///        usersUseCase.report(email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to get the list of books
    public func read(_ email: String) async throws -> Report {
        try await repository.read(email)
    }
}
