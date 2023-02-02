//
//  HomeView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ModuleDependencies.shared.booksView()
            }
            .tabItem {
                Label("Books", systemImage: "book")
            }
            
            NavigationStack {
                ModuleDependencies.shared.clientsView()
            }
            .tabItem {
                Label("Clients", systemImage: "person")
            }
            
            NavigationStack {
                ModuleDependencies.shared.shopView()
            }
            .tabItem {
                Label("Shop", systemImage: "cart")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
