//
//  BooksUseCase.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

public protocol BooksUseCaseProtocol {
    func fetch() async throws -> [Book]
    func fetchLatest() async throws -> [Book]
    func find(startingWith text: String) async throws -> [Book]
    func read(_ readBooks: ReadBooks) async throws
    func getReport(_ email: String) async throws -> Report
}

public final class BooksUseCase: BooksUseCaseProtocol {
    private var user: User? {
        Storage.shared.get(key: .user, type: User.self)
    }
    private let repository: BooksRepositoryProtocol
    private let usersRepository: UsersRepositoryProtocol
    
    public init(dependencies: BooksDependenciesResolver) {
        self.repository = dependencies.resolve()
        self.usersRepository = dependencies.resolve()
    }
    
    /// Fetch the full list of books.
    /// ```
    ///        booksUseCase.fetch()
    /// ```
    public func fetch() async throws -> [Book] {
        if let books = Cache.shared.books {
            return books
        }
        let books = try await repository.getBooks()
        let booksFormattedList = try await getBookList(from: books)
        Cache.shared.books = booksFormattedList
        return booksFormattedList
    }
    
    /// Fetch last 20 books. Every call returns a different list of books
    /// ```
    ///        booksUseCase.fetchLatest()
    /// ```
    public func fetchLatest() async throws -> [Book] {
        let books = try await repository.getLatestBooks()
        return try await getBookList(from: books)
    }
    
    /// Find books starting with some text
    /// ```
    ///        booksUseCase.find(startingWith: "some text")
    /// ```
    /// - Parameters:
    ///   - startingWith: Find books that starts with that string
    public func find(startingWith text: String) async throws -> [Book] {
        let books = try await repository.findBook(with: text)
        return try await getBookList(from: books)
    }
    
    /// Mark books as read
    /// ```
    ///        booksUseCase.markRead(readBooks)
    /// ```
    /// - Parameters:
    ///   - readBooks: Books to mark as read
    public func read(_ readBooks: ReadBooks) async throws {
        _ = try await usersRepository.markRead(readBooks)
    }
    
    /// Get books read and purchased of a user by email
    /// ```
    ///        usersUseCase.report(email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to get the list of books
    public func getReport(_ email: String) async throws -> Report {
        try await usersRepository.report(email)
    }
    
    /// Private function to get books with all data (authors, read, buy, etc)
    /// ```
    ///        getBookList(from: booksList)
    /// ```
    /// - Parameters:
    ///   - from: The string to repeat.
    private func getBookList(from list: [Book]) async throws -> [Book] {
        let report = try? await getReport(user?.email ?? "")
        let authors = try? await repository.getAuthors()
        let returnValues = list.map { book in
            var book = book
            book.author = authors?.first(where: { $0.id == book.author })?.name ?? ""
            book.purchased = report?.ordered?.contains(book.apiID) ?? false
            book.read = report?.read?.contains(book.apiID) ?? false
            return book
        }
        return returnValues
    }
}
