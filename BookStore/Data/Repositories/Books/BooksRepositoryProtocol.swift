//
//  BooksRepositoryProtocol.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

protocol BooksRepositoryProtocol {
    func getBooks() async throws -> [Book]
    func getLatestBooks() async throws -> [Book]
    func findBook(with text: String) async throws -> [Book]
    func getAuthors() async throws -> [Author]
}
