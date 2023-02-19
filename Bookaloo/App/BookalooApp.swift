//
//  BookalooApp.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import SwiftUI

@main
struct BookalooApp: App {
    let moduleDependencies = ModuleDependencies()
    var loginHomeView: LoginHomeView {
        moduleDependencies.resolve()
    }
    
    var body: some Scene {
        WindowGroup {
           loginHomeView
                .environmentObject(moduleDependencies.resolve() as LoginViewModel)
                .environmentObject(moduleDependencies.resolve() as BooksViewModel)
                .environmentObject(moduleDependencies.resolve() as ShopViewModel)
                .environmentObject(moduleDependencies.resolve() as UsersViewModel)
        }
    }
}
