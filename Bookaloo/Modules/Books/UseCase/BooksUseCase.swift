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
}

final class BooksUseCase: BooksUseCaseProtocol {
    let repository: BooksRepositoryProtocol
    
    init(dependencies: BooksDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
    func fetch() async throws -> [Book] {
        let books = try await repository.getBooks()
        return try await getBookList(from: books)
    }
    
    func fetchLatest() async throws -> [Book] {
        let books = try await repository.getLatestBooks()
        return try await getBookList(from: books)
    }
    
    func find(startingWith text: String) async throws -> [Book] {
        let books = try await repository.findBook(with: text)
        return try await getBookList(from: books)
    }
    
    private func getBookList(from list: [Book]) async throws -> [Book] {
        var returnValues = [Book]()
        for try await book in AsyncBooks(books: list) {
            var book = book
            let author = try await repository.getAuthors().first(where: { $0.id == book.author })
            book.author = author?.name ?? ""
            returnValues.append(book)
        }
        return returnValues
    }
}
