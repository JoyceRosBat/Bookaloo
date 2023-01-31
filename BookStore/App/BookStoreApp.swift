//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import SwiftUI

@main
struct BookStoreApp: App {
    var moduleDependencies = ModuleDependencies()
    
    var body: some Scene {
        WindowGroup {
            moduleDependencies.booksView()
        }
    }
}
