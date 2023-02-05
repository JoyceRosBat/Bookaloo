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
    var books = [Book]()
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
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
