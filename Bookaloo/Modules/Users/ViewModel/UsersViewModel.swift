//
//  UsersViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

final class UsersViewModel: ObservableBaseViewModel {
    let dependencies: UsersDependenciesResolver
    var usersUseCase: UsersUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: UsersDependenciesResolver) {
        self.dependencies = dependencies
    }
    
}
