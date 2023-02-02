//
//  BookalooApp.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import SwiftUI

@main
struct BookalooApp: App {
    var body: some Scene {
        WindowGroup {
            ModuleDependencies.shared.homeView()
        }
    }
}
