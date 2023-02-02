//
//  BooksUseCase.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

protocol BooksUseCaseProtocol {
    func fetch() async throws -> [Book]
    func fetchLatest() async throws -> [Book]
    func find(startingWith text: String) async throws -> [Book]
    func fetchAuthors() async throws -> [Author]
}

final class BooksUseCase: BooksUseCaseProtocol {
    let repository: BooksRepositoryProtocol
    
    init(dependencies: BooksDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    func fetch() async throws -> [Book] {
        try await repository.getBooks()
    }
    
    func fetchLatest() async throws -> [Book] {
        try await repository.getLatestBooks()
    }
    
    func find(startingWith text: String) async throws -> [Book] {
        try await repository.findBook(with: text)
    }
    
    func fetchAuthors() async throws -> [Author] {
        try await repository.getAuthors()
    }
}
