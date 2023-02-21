//
//  BooksRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

public final class BooksRepository: BooksRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    public init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    public func getBooks() async throws -> [Book] {
        if let books = Cache.shared.books {
            return books
        }
        let request = BooksRequest.list
        let books: [Book] = try await networkRequester.doRequest(request: request)
        Cache.shared.books = books
        return books
    }
    
    public func getLatestBooks() async throws -> [Book] {
        let request = BooksRequest.latest
        return try await networkRequester.doRequest(request: request)
    }
    
    public func findBook(with text: String) async throws -> [Book] {
        let request = BooksRequest.find(text)
        return try await networkRequester.doRequest(request: request)
    }
    
    public func getAuthor(_ id: String) async throws -> Author {
        let request = BooksRequest.author(id)
        return try await networkRequester.doRequest(request: request)
    }
    
    public func getAuthors() async throws -> [Author] {
        if let authors = Cache.shared.authors {
            return authors
        }
        let request = BooksRequest.authors
        let authors: [Author] = try await networkRequester.doRequest(request: request)
        
        Cache.shared.authors = authors
        return authors
    }
}
