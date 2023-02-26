//
//  BooksAPITest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import XCTest
@testable import Bookaloo

final class BooksAPITest: XCTestCase {
    var mockDependenciesResolver = MockNetworkRequestDependenciesResolver()
    var booksRepository: BooksRepositoryProtocol?
    
    override func setUpWithError() throws {
        booksRepository = mockDependenciesResolver.resolve()
    }

    override func tearDownWithError() throws {
        booksRepository = nil
    }

    func test_fetch_books_with_success() async throws {
        let books = try await booksRepository?.getBooks()
        XCTAssert(books?.first?.isbn == "0451528557")
        XCTAssert(books?.first?.author == "531EDFA6-A361-4E15-873F-45E4EA0AF120")
        XCTAssert(books?.first?.title == "The Time Machine")
    }
    
    func test_fetch_books_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 404)
        do {
            _ = try await booksRepository?.getBooks()
        } catch let error as MockError {
            XCTAssert(error.code == 404)
            XCTAssert(error.errorCode == "404")
        }
    }
    
    func test_fetch_latest_with_success() async throws {
        let latest = try await booksRepository?.getLatestBooks()
        XCTAssert(latest?.first?.title == "The Dark Door")
    }
    
    func test_fetch_latest_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 400)
        do {
            _ = try await booksRepository?.getLatestBooks()
        } catch let error as MockError {
            XCTAssert(error.code == 400)
            XCTAssert(error.errorCode == "400")
        }
    }
    
    func test_find_books_with_success() async throws {
        let find = try await booksRepository?.findBook(with: "time")
        XCTAssert(find?.first?.author == "531EDFA6-A361-4E15-873F-45E4EA0AF120")
    }
    
    func test_find_books_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 500)
        do {
            _ = try await booksRepository?.findBook(with: "time")
        } catch let error as MockError {
            XCTAssert(error.code == 500)
            XCTAssert(error.errorCode == "500")
        }
    }
    
    func test_fetch_authors_with_success() async throws {
        let authors = try await booksRepository?.getAuthors()
        XCTAssert(authors?.first?.id == "531EDFA6-A361-4E15-873F-45E4EA0AF120")
    }
    
    func test_fetch_authors_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 401)
        do {
            _ = try await booksRepository?.getAuthors()
        } catch let error as MockError {
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
    
    func test_get_author_by_id_with_success() async throws {
        let author = try await booksRepository?.getAuthor("531EDFA6-A361-4E15-873F-45E4EA0AF120")
        XCTAssert(author?.name == "H. G. Wells")
    }
    
    func testget_author_by_id_should_fail() async throws {
        mockDependenciesResolver = MockNetworkRequestDependenciesResolver(shouldFail: true, failError: 401)
        do {
            _ = try await booksRepository?.getAuthor("531EDFA6-A361-4E15-873F-45E4EA0AF120")
        } catch let error as MockError {
            XCTAssert(error.code == 401)
            XCTAssert(error.errorCode == "401")
        }
    }
}
