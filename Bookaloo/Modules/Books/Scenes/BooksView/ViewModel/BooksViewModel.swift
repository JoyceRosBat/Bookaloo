//
//  BooksViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

public final class BooksViewModel: ObservableBaseViewModel {
    @Published var searchText: String = ""
    @Published var books = [Book]()
    
    let dependencies: BooksDependenciesResolver
    var booksUseCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    
    var filteredBooks: [Book] {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    var report: Report = Report(email: "", ordered: [], read: [], books: [])
    
    public init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    // On appear, fetch list of books
    public override func onAppear() {
        super.onAppear()
        Task { [weak self] in
            guard let self = self else { return }
            await MainActor.run {
                self.getBooks()
                self.getReport()
            }
        }
    }
    
    /// Get the books read and ordered by the user
    /// ```
    ///        viewModel.getReport()
    /// ```
    @MainActor
    public func getReport() {
        showLoading(true)
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.report = try await self.booksUseCase.getReport(user?.email ?? "")
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
            }
        }
    }
    
    /// Get list of books
    /// ```
    ///        viewModel.getBooks()
    /// ```
    @MainActor
    public func getBooks(removingCache: Bool = false) {
        showLoading(true)
        Task { [weak self] in
            guard let self = self else { return }
            do {
                if removingCache {
                    Cache.shared.clean()
                }
                self.books = try await self.booksUseCase.fetch()
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
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
    public func markAsRead(_ book: Book) {
        Task { [weak self] in
            guard let self = self else { return }
            let readBooks = ReadBooks(email: user?.email ?? "", books: [book.apiID])
            try await self.booksUseCase.read(readBooks)
            self.report = try await self.booksUseCase.getReport(user?.email ?? "")
            
            if let index = self.books.firstIndex(of: book) {
                self.books[index].read = self.report.read?.contains(book.apiID) == true
            }
            Cache.shared.books = self.books
        }
    }
}
