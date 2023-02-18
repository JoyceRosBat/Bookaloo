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
    func read(_ readBooks: ReadBooks) async throws
    func getReport(_ email: String) async throws -> Report
}

final class BooksUseCase: BooksUseCaseProtocol {
    private var user: User? {
        Storage.shared.get(key: .user, type: User.self)
    }
    private let repository: BooksRepositoryProtocol
    private let usersRepository: UsersRepositoryProtocol
    
    init(dependencies: BooksDependenciesResolver) {
        self.repository = dependencies.resolve()
        self.usersRepository = dependencies.resolve()
    }
    
    /// Fetch the full list of books.
    /// ```
    ///        booksUseCase.fetch()
    /// ```
    func fetch() async throws -> [Book] {
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
    
    /// Mark books as read
    /// ```
    ///        booksUseCase.markRead(readBooks)
    /// ```
    /// - Parameters:
    ///   - readBooks: Books to mark as read
    func read(_ readBooks: ReadBooks) async throws {
        _ = try await usersRepository.markRead(readBooks)
    }
    
    /// Get books read and purchased of a user by email
    /// ```
    ///        usersUseCase.report(email)
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to get the list of books
    func getReport(_ email: String) async throws -> Report {
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
        var returnValues = [Book]()
        for try await item in AsyncBooks(books: list) {
            var book = item
            print(book.id)
            let author = try await repository.getAuthors().first(where: { $0.id == book.author })
            book.author = author?.name ?? ""
            book.purchased = report?.ordered?.contains(book.id) ?? false
            book.read = report?.readed?.contains(book.id) ?? false
            if book.price == nil {
                book.price = Double.random(in: 5...50)
            }
            returnValues.append(book)
        }
        return returnValues
    }
}
