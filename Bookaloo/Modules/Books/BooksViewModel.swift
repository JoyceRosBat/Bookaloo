//
//  BooksViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class BooksViewModel: ObservableBaseViewModel {
    let dependencies: BooksDependenciesResolver
    var booksUseCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    override func onAppear() {
        Task {
            do {
                let books = try await booksUseCase.fetch()
                print(books)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}
