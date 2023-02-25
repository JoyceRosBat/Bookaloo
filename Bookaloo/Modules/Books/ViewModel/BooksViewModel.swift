//
//  BooksViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class BooksViewModel: ObservableBaseViewModel {
    @Published var searchText: String = ""
    @Published var books = [Book]()
    
    let dependencies: BooksDependenciesResolver
    var booksUseCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    
    var filteredBooks: [Book] {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    var report: Report = Report(email: "", ordered: [], readed: [], books: [])
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    // On appear, fetch list of books
    override func onAppear() {
        super.onAppear()
        Task {
            await MainActor.run {
                getBooks()
                getReport()
            }
        }
    }
    
    /// Get the books read and ordered by the user
    /// ```
    ///        viewModel.getReport()
    /// ```
    @MainActor
    func getReport() {
        showLoading(true)
        Task {
            do {
                report = try await booksUseCase.getReport(user?.email ?? "")
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Get list of books
    /// ```
    ///        viewModel.getBooks()
    /// ```
    @MainActor
    func getBooks(removingCache: Bool = false) {
        showLoading(true)
        Task {
            do {
                if removingCache {
                    Cache.shared.books = nil
                }
                books = try await booksUseCase.fetch()
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Mark books as read
    /// ```
    ///        viewModel.markRead(readBooks)
    /// ```
    /// - Parameters:
    ///   - readBooks: Books to mark as read
    @MainActor
    func markAsRead(_ book: Book) {
        Task {
            if report.readed?.contains(book.apiID) == true {
                report.readed?.removeAll(where: { $0 == book.apiID })
            } else {
                report.readed?.append(book.apiID)
            }
            
            let readBooks = ReadBooks(email: user?.email ?? "", books: report.readed ?? [book.apiID])
            try await booksUseCase.read(readBooks)
            
            books = books.compactMap { item in
                var item = item
                if item.apiID == book.apiID {
                    item.read = report.readed?.contains(book.apiID) == true
                }
                return item
            }
        }
    }
}
