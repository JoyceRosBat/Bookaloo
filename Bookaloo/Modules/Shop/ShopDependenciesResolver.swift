//
//  ShopDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol ShopDependenciesResolver {
    func resolve() -> ShopRepositoryProtocol
    func resolve() -> ShopUseCaseProtocol
    func resolve() -> ShopViewModel
    func shopView() -> ShopView
}

extension ShopDependenciesResolver {
    func resolve() -> ShopUseCaseProtocol {
        ShopUseCase(dependencies: self)
    }
    
    func resolve() -> ShopViewModel {
        ShopViewModel(dependencies: self)
    }
    
    func shopView() -> ShopView {
        ShopView(viewModel: resolve())
    }
}
