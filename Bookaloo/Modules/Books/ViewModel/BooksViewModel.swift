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
        getBooks()
        getReport()
    }
    
    /// Get the books read and ordered by the user
    /// ```
    ///        viewModel.getReport()
    /// ```
    func getReport() {
        showLoading(true)
        Task {
            await MainActor.run {
                Task {
                    do {
                        report = try await booksUseCase.getReport(user?.email ?? "")
                        showLoading(false)
                    } catch let error as NetworkError {
                        showNetworkError(error)
                    }
                }
            }
        }
    }
    
    /// Get list of books
    /// ```
    ///        viewModel.getBooks()
    /// ```
    func getBooks(removingCache: Bool = false) {
        showLoading(true)
        Task {
            await MainActor.run {
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
        }
    }
    
    /// Mark books as read
    /// ```
    ///        viewModel.markRead(readBooks)
    /// ```
    /// - Parameters:
    ///   - readBooks: Books to mark as read
    func markAsRead(_ book: Book) {
        Task {
            if report.readed?.contains(book.id) == true {
                report.readed?.removeAll(where: { $0 == book.id })
            } else {
                report.readed?.append(book.id)
            }
            
            let readBooks = ReadBooks(email: user?.email ?? "", books: report.readed ?? [book.id])
            try await booksUseCase.read(readBooks)
            
            await MainActor.run {
                books = books.compactMap { item in
                    var item = item
                    if item.id == book.id {
                        item.read = report.readed?.contains(book.id) == true
                    }
                    return item
                }
            }
        }
    }
}
