//
//  MockBooksDependenciesResolver.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import Foundation
import Bookaloo

final class MockBooksDependenciesResolver: BooksDependenciesResolver {
    var networkDependenciesResolver = MockNetworkRequestDependenciesResolver()
    
    func resolve() -> BooksRepositoryProtocol {
        BooksRepository(dependencies: networkDependenciesResolver)
    }
    
    func resolve() -> UsersRepositoryProtocol {
        UsersRepository(dependencies: networkDependenciesResolver)
    }
    
    func resolve() -> BooksUseCaseProtocol {
        BooksUseCase(dependencies: self)
    }
    
    func resolve() -> BooksViewModel {
        BooksViewModel(dependencies: self)
    }
    
    func resolve() -> BooksHomeView {
        fatalError()
    }
    
    func resolve() -> BooksView {
        fatalError()
    }
    
    func resolve() -> BooksViewiPad {
        fatalError()
    }
    
    func resolve(_ book: Book) -> BookDetailsView {
        fatalError()
    }
    
    func resolve() -> LoginHomeView {
        fatalError()
    }
}
