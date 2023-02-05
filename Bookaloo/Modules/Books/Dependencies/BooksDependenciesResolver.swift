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
    func booksViewModel() -> BooksViewModel
    func booksView() -> BooksView
    func booksContentView() -> BooksContentView
    func loginView() -> LoginView
}

extension BooksDependenciesResolver {
    func resolve() -> BooksUseCaseProtocol {
        BooksUseCase(dependencies: self)
    }
    
    func booksViewModel() -> BooksViewModel {
        BooksViewModel(dependencies: self)
    }
    
    func booksContentView() -> BooksContentView {
        BooksContentView()
    }
    
    func booksView() -> BooksView {
        BooksView(dependencies: self)
    }
}
