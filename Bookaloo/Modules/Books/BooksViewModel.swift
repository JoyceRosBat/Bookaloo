//
//  BooksViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class BooksViewModel: ObservableObject {
    let dependencies: BooksDependenciesResolver
    var booksUseCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    func fetchBooks() {
        Task {
            let books = try await booksUseCase.fetch()
            print(books)
        }
    }
}
