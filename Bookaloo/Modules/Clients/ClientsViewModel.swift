//
//  ClientsViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

final class ClientsViewModel: ObservableObject {
    let dependencies: ClientsDependenciesResolver
    var clientsUseCase: ClientsUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: ClientsDependenciesResolver) {
        self.dependencies = dependencies
    }
    
}
