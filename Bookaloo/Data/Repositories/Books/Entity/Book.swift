//
//  Book.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

import Foundation

// MARK: - Book
struct Book: Codable, Identifiable, Hashable {
    let pages: Int?
    let year: Int
    let id: Int
    let rating: Double?
    let cover: URL?
    let summary: String?
    var author: String
    let isbn: String?
    let title: String
    let plot: String?
}

struct AsyncBooks: AsyncSequence {
    typealias AsyncIterator = BooksIterator
    typealias Element = Book
    
    let books: [Book]
    
    struct BooksIterator: AsyncIteratorProtocol {
        typealias Element = Book
        var books: IndexingIterator<[Book]>
        
        mutating func next() async throws -> Book? {
            guard let nextBook = books.next() else { return nil }
            return nextBook
        }
    }
    
    func makeAsyncIterator() -> BooksIterator {
        BooksIterator(books: books.makeIterator())
    }
}
