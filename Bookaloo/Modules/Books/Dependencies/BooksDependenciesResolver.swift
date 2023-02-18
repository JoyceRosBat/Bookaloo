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
    func booksViewModel() -> BooksViewModel
    func booksHomeView() -> BooksHomeView
    func booksView() -> BooksView
    func bookDetailsView(_ book: Book) -> BookDetailsView
    func loginView() -> LoginView
}

extension BooksDependenciesResolver {
    func resolve() -> BooksUseCaseProtocol {
        BooksUseCase(dependencies: self)
    }
    
    func booksViewModel() -> BooksViewModel {
        BooksViewModel(dependencies: self)
    }
    
    func booksView() -> BooksView {
        BooksView(dependencies: self)
    }
    
    func booksHomeView() -> BooksHomeView {
        BooksHomeView(dependencies: self)
    }
    
    func bookDetailsView(_ book: Book) -> BookDetailsView {
        BookDetailsView(book: book)
    }
}
