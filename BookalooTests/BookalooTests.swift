//
//  BookalooTests.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import XCTest
@testable import Bookaloo

final class BookalooTests: XCTestCase {
    
    var mockDependenciesResolver = MockNetworkRequestDependenciesResolver()
    var booksRepository: BooksRepositoryProtocol?
    
    override func setUpWithError() throws {
        booksRepository = mockDependenciesResolver.resolve()
    }

    override func tearDownWithError() throws {
        booksRepository = nil
    }

    func test_fetch_books_with_success() async throws {
        booksRepository = mockDependenciesResolver.resolve()
        let books = try await booksRepository?.getBooks()
        XCTAssert(books?.first!.isbn == "0451528557")
    }
    
    func test_fetch_books_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            try await booksRepository?.getBooks()
        } catch let error as MockError {
            XCTAssert(error.code == 404)
        }
    }
}
