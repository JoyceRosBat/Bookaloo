//
//  ClientsUseCase.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol ClientsUseCaseProtocol {
    
}

final class ClientsUseCase: ClientsUseCaseProtocol {
    
    let repository: ClientsRepositoryProtocol
    
    init(dependencies: ClientsDependenciesResolver) {
        self.repository = dependencies.resolve()
    }
    
}
