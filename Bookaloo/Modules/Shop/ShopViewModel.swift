//
//  ShopViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

final class ShopViewModel: ObservableObject {
    let dependencies: ShopDependenciesResolver
    var shopUseCase: ShopUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: ShopDependenciesResolver) {
        self.dependencies = dependencies
    }
}
