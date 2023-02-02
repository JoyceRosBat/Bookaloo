//
//  BooksDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

protocol BooksDependenciesResolver {
    func resolve() -> BooksRepositoryProtocol
    func resolve() -> BooksUseCaseProtocol
    func resolve() -> BooksViewModel
    func booksView() -> BooksView
}

extension BooksDependenciesResolver {
    func resolve() -> BooksUseCaseProtocol {
        BooksUseCase(dependencies: self)
    }
    
    func resolve() -> BooksViewModel {
        BooksViewModel(dependencies: self)
    }
    
    func booksView() -> BooksView {
        BooksView(viewModel: resolve())
    }
}
