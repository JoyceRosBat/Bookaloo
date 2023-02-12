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
    let usersRepository: UsersRepositoryProtocol
    
    init(dependencies: BooksDependenciesResolver) {
        self.repository = dependencies.resolve()
        self.usersRepository = dependencies.resolve()
    }
    
    /// Fetch the full list of books.
    /// ```
    ///        booksUseCase.fetch()
    /// ```
    func fetch() async throws -> [Book] {
        let books = try await repository.getBooks()
        return try await getBookList(from: books)
    }
    
    /// Fetch last 20 books. Every call returns a different list of books
    /// ```
    ///        booksUseCase.fetchLatest()
    /// ```
    func fetchLatest() async throws -> [Book] {
        let books = try await repository.getLatestBooks()
        return try await getBookList(from: books)
    }
    
    /// Find books starting with some text
    /// ```
    ///        booksUseCase.find(startingWith: "some text")
    /// ```
    /// - Parameters:
    ///   - startingWith: Find books that starts with that string
    func find(startingWith text: String) async throws -> [Book] {
        let books = try await repository.findBook(with: text)
        return try await getBookList(from: books)
    }
    
    /// Private function to get books with all data (authors, read, buy, etc)
    /// ```
    ///        getBookList(from: booksList)
    /// ```
    /// - Parameters:
    ///   - from: The string to repeat.
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
