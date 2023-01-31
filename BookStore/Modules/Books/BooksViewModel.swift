//
//  BooksViewModel.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class BooksViewModel: ObservableObject {
    let dependencies: BooksDependenciesResolver
    var useCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    func fetchBooks() {
        Task {
            try await useCase.fetchBooks()
        }
    }
}
