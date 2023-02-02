//
//  NetworkRepositoryDependenciesResolver.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol NetworkRepositoryDependenciesResolver {
    func resolve() -> NetworkRequesterProtocol
    func resolve() -> BooksRepositoryProtocol
    func resolve() -> ClientsRepositoryProtocol
    func resolve() -> ShopRepositoryProtocol
}

extension NetworkRepositoryDependenciesResolver {
    func resolve() -> BooksRepositoryProtocol {
        BooksRepository(dependencies: self)
    }
    
    func resolve() -> ClientsRepositoryProtocol {
        ClientsRepository(dependencies: self)
    }
    
    func resolve() -> ShopRepositoryProtocol {
        ShopRepository(dependencies: self)
    }
}
