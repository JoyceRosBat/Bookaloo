//
//  BooksViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class BooksViewModel: ObservableBaseViewModel {
    @Published var searchText: String = ""
    
    let dependencies: BooksDependenciesResolver
    var booksUseCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    var books = [Book]()
    var filteredBooks: [Book] {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    // On appear, fetch list of books
    override func onAppear() {
        showLoading(true)
        Task {
            do {
                books = try await booksUseCase.fetch()
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}
