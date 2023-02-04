//
//  ModuleDependencies.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class ModuleDependencies {
    func homeView() -> HomeView {
        HomeView(dependencies: self)
    }
    
    func resolve() -> NetworkRequesterProtocol {
        NetworkRequester()
    }
}
extension ModuleDependencies: CommonModulesDependenciesResolver {}
extension ModuleDependencies: NetworkRepositoryDependenciesResolver {}
