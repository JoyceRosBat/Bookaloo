//
//  BooksRepository.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

final class BooksRepository: BooksRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    init(dependencies: NetworkRepositoryDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    func getBooks() async throws -> [Book] {
        if let books = Cache.shared.books {
            return books
        }
        let request = BooksRequest.list
        let books = try await networkRequester.doRequest(request: request) as [Book]
        Cache.shared.books = books
        return books
    }
    
    func getLatestBooks() async throws -> [Book] {
        let request = BooksRequest.latest
        return try await networkRequester.doRequest(request: request)
    }
    
    func findBook(with text: String) async throws -> [Book] {
        let request = BooksRequest.find(text)
        return try await networkRequester.doRequest(request: request)
    }
    
    func getAuthor(_ id: String) async throws -> Author {
        let request = BooksRequest.author(id)
        return try await networkRequester.doRequest(request: request) as Author
    }
    
    func getAuthors() async throws -> [Author] {
        if let authors = Cache.shared.authors {
            return authors
        }
        let request = BooksRequest.authors
        let authors = try await networkRequester.doRequest(request: request) as [Author]
        
        Cache.shared.authors = authors
        return authors
    }
}
