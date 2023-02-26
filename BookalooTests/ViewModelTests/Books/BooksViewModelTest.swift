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
    var mockBooksDependenciesResolver = MockBooksDependenciesResolver()
    var viewModel: BooksViewModel?
    
    override func setUp() {
        viewModel = mockBooksDependenciesResolver.resolve()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func test_on_appear_with_success() {
        viewModel?.onAppear()
        wait(self.viewModel?.books.first?.isbn == "0451528557")
        wait(self.viewModel?.books.first?.author == "H. G. Wells")
        wait(self.viewModel?.report.ordered?.count == 5)
        wait(self.viewModel?.report.read?.contains(2) == true)
        wait(self.viewModel?.report.email == "joyce.admin@bookaloo.com")
    }
    
    func test_get_report_with_success() {
        viewModel?.getReport()
        wait(self.viewModel?.report.ordered?.count == 5)
        wait(self.viewModel?.report.read?.contains(2) == true)
        wait(self.viewModel?.report.email == "joyce.admin@bookaloo.com")
    }
    
    func test_get_books_with_success() {
        viewModel?.getBooks()
        wait(self.viewModel?.books.first?.isbn == "0451528557")
        wait(self.viewModel?.books.first?.author == "H. G. Wells")
    }
    
    func test_mark_book_read_with_success() {
        let book = Book(
            apiID: 1,
            pages: 100,
            year: 1985,
            rating: 5,
            cover: nil,
            summary: "",
            author: "",
            isbn: "",
            title: "",
            plot: "",
            read: false
        )
        viewModel?.books.append(book)
        viewModel?.markAsRead(book)
        let bookRead = viewModel?.books.first(where: { $0.apiID == book.apiID })
        wait(bookRead?.read == false)
    }
}
