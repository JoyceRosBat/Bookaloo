//
//  BooksDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

protocol BooksDependenciesResolver {
    func resolve() -> BooksRepositoryProtocol
    func resolve() -> UsersRepositoryProtocol
    func resolve() -> BooksUseCaseProtocol
    func resolve() -> BooksViewModel
    func resolve() -> BooksHomeView
    func resolve() -> BooksView
    func resolve(_ book: Book) -> BookDetailsView
    func resolve() -> LoginHomeView
}

extension BooksDependenciesResolver {
    func resolve() -> BooksUseCaseProtocol {
        BooksUseCase(dependencies: self)
    }
    
    func resolve() -> BooksViewModel {
        BooksViewModel(dependencies: self)
    }
    
    func resolve() -> BooksView {
        BooksView(dependencies: self)
    }
    
    func resolve() -> BooksHomeView {
        BooksHomeView(dependencies: self)
    }
    
    func resolve(_ book: Book) -> BookDetailsView {
        BookDetailsView(book: book)
    }
}
