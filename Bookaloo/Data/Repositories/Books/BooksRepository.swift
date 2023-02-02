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
        let request = BooksRequest.list
        return try await networkRequester.doRequest(request: request)
    }
    
    func getLatestBooks() async throws -> [Book] {
        let request = BooksRequest.latest
        return try await networkRequester.doRequest(request: request)
    }
    
    func findBook(with text: String) async throws -> [Book] {
        let request = BooksRequest.find(text)
        return try await networkRequester.doRequest(request: request)
    }
    
    func getAuthors() async throws -> [Author] {
        let request = BooksRequest.authors
        return try await networkRequester.doRequest(request: request)
    }
}
