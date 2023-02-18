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
    
    var body: some Scene {
        WindowGroup {
            moduleDependencies
                .loginHomeView()
                .environmentObject(moduleDependencies.loginViewModel())
                .environmentObject(moduleDependencies.booksViewModel())
                .environmentObject(moduleDependencies.shopsViewModel())
                .environmentObject(moduleDependencies.usersViewModel())
        }
    }
}
