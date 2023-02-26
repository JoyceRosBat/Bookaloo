//
//  ShopDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

public protocol ShopDependenciesResolver {
    func resolve() -> ShopRepositoryProtocol
    func resolve() -> ShopUseCaseProtocol
    func resolve() -> ShopViewModel
    func resolve() -> ShopOrdersViewModel
    func resolve() -> HandleOrderViewModel
    func resolve() -> ShopView
    func resolve() -> ShopOrdersView
    func resolve() -> HandleOrdersView
}

extension ShopDependenciesResolver {
    func resolve() -> ShopUseCaseProtocol {
        ShopUseCase(dependencies: self)
    }
    
    func resolve() -> ShopViewModel {
        ShopViewModel(dependencies: self)
    }
    
    func resolve() -> ShopView {
        ShopView(dependencies: self)
    }
    
    func resolve() -> ShopOrdersViewModel {
        ShopOrdersViewModel(dependencies: self)
    }
    
    func resolve() -> ShopOrdersView {
        ShopOrdersView(viewModel: resolve())
    }
    
    func resolve() -> HandleOrderViewModel {
        HandleOrderViewModel(dependencies: self)
    }
    
    func resolve() -> HandleOrdersView {
        HandleOrdersView(viewModel: resolve())
    }
}
