//
//  MockShopDependenciesResolver.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 26/2/23.
//

import Foundation
import Bookaloo

final class MockShopDependenciesResolver: ShopDependenciesResolver {
    var networkDependenciesResolver = MockNetworkRequestDependenciesResolver()
    
    func resolve() -> ShopRepositoryProtocol {
        ShopRepository(dependencies: networkDependenciesResolver)
    }
    
    func resolve() -> ShopUseCaseProtocol {
        ShopUseCase(dependencies: self)
    }
    
    func resolve() -> ShopViewModel {
        ShopViewModel(dependencies: self)
    }
    
    func resolve() -> ShopOrdersViewModel {
        ShopOrdersViewModel(dependencies: self)
    }
    
    func resolve() -> HandleOrderViewModel {
        HandleOrderViewModel(dependencies: self)
    }
    
    func resolve() -> ShopView {
        fatalError()
    }
    
    func resolve() -> ShopOrdersView {
        fatalError()
    }
    
    func resolve() -> HandleOrdersView {
        fatalError()
    }
}
