//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import SwiftUI

@main
struct BookStoreApp: App {
    var body: some Scene {
        WindowGroup {
            ModuleDependencies.shared.homeView()
        }
    }
}
