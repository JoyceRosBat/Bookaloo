//
//  ClientsDependenciesResolver.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

protocol ClientsDependenciesResolver {
    func resolve() -> ClientsRepositoryProtocol
    func resolve() -> ClientsUseCaseProtocol
    func resolve() -> ClientsViewModel
    func clientsView() -> ClientsView
}

extension ClientsDependenciesResolver {
    func resolve() -> ClientsUseCaseProtocol {
        ClientsUseCase(dependencies: self)
    }
    
    func resolve() -> ClientsViewModel {
        ClientsViewModel(dependencies: self)
    }
    
    func clientsView() -> ClientsView {
        ClientsView(viewModel: resolve())
    }
}
