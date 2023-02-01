//
//  ShopUseCase.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol ShopUseCaseProtocol {
    
}

final class ShopUseCase: ShopUseCaseProtocol {
    let repository: ShopRepositoryProtocol
    
    init(dependencies: ShopDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
}
