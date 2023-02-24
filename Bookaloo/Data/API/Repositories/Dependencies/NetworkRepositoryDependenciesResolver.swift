//
//  NetworkRepositoryDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

public protocol NetworkRepositoryDependenciesResolver {
    func resolve() -> NetworkRequesterProtocol
    func resolve() -> LoginRepositoryProtocol
    func resolve() -> BooksRepositoryProtocol
    func resolve() -> UsersRepositoryProtocol
    func resolve() -> ShopRepositoryProtocol
}

public extension NetworkRepositoryDependenciesResolver {
    func resolve() -> LoginRepositoryProtocol {
        LoginRepository(dependencies: self)
    }
    
    func resolve() -> BooksRepositoryProtocol {
        BooksRepository(dependencies: self)
    }
    
    func resolve() -> UsersRepositoryProtocol {
        UsersRepository(dependencies: self)
    }
    
    func resolve() -> ShopRepositoryProtocol {
        ShopRepository(dependencies: self)
    }
}
