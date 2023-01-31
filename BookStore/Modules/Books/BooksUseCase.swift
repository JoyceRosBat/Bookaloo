//
//  BooksUseCase.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

protocol BooksUseCaseProtocol {
    func fetchBooks() async throws -> [Book]
}

final class BooksUseCase: BooksUseCaseProtocol {
    let repository: BooksRepositoryProtocol
    
    init(dependencies: BooksDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    func fetchBooks() async throws -> [Book] {
        try await repository.getBooks()
    }
}
