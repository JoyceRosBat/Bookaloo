//
//  ModuleDependencies.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class ModuleDependencies {
    static let shared: ModuleDependencies = ModuleDependencies()
    private init() {}
    
    func homeView() -> HomeView {
        HomeView()
    }
    
    func resolve() -> NetworkRequesterProtocol {
        NetworkRequester()
    }
}
extension ModuleDependencies: CommonModulesDependenciesResolver {}
extension ModuleDependencies: NetworkRepositoryDependenciesResolver {}
