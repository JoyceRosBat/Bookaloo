//
//  BooksViewModelTest.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import XCTest
@testable import Bookaloo

@MainActor
final class BooksViewModelTest: XCTestCase {
    var mockDependenciesResolver = MockBooksDependenciesResolver()
    var viewModel: BooksViewModel?
    
    override func setUp() {
        viewModel = mockDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_on_appear_with_success() {
        // When
        viewModel?.onAppear()
        // Then
        wait(self.viewModel?.books.first?.isbn == "0451528557")
        wait(self.viewModel?.books.first?.author == "H. G. Wells")
        wait(self.viewModel?.report.ordered?.count == 5)
        wait(self.viewModel?.report.read?.contains(2) == true)
        wait(self.viewModel?.report.email == "joyce.admin@bookaloo.com")
    }
    
    func test_get_report_with_success() {
        // When
        viewModel?.getReport()
        // Then
        wait(self.viewModel?.report.ordered?.count == 5)
        wait(self.viewModel?.report.read?.contains(2) == true)
        wait(self.viewModel?.report.email == "joyce.admin@bookaloo.com")
    }
    
    func test_get_books_with_success() {
        // When
        viewModel?.getBooks()
        // Then
        wait(self.viewModel?.books.first?.isbn == "0451528557")
        wait(self.viewModel?.books.first?.author == "H. G. Wells")
    }
    
    func test_mark_book_read_with_success() {
        // When
        viewModel?.onAppear()
        // Then
        wait(self.viewModel?.books.first != nil)
        if var book = viewModel?.books.first {
            // Given
            book.read = false
            viewModel?.report.read?.removeAll(where: { $0 == book.apiID })
            // When
            viewModel?.markAsRead(book)
            // Then
            wait(self.viewModel?.books.first?.read == true)
        }
    }
    
    func test_mark_book_not_read_with_success() {
        // When
        viewModel?.onAppear()
        wait(self.viewModel?.books.first != nil)
        if var book = viewModel?.books.first {
            // Given
            book.read = true
            viewModel?.report.read?.append(book.apiID)
            // When
            viewModel?.markAsRead(book)
            // Then
            wait(self.viewModel?.books.first?.read == false)
        }
    }
}
