//
//  HomeView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct HomeView: View {
    let dependencies: CommonModulesDependenciesResolver
    @EnvironmentObject var viewModel: LoginViewModel
    var booksView: BooksView {
        dependencies.booksView()
    }
    var clientsView : ClientsView { dependencies.clientsView()
    }
    var shopView: ShopView {
        dependencies.shopView()
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                booksView
            }
            .tabItem {
                Label("Books", systemImage: "book")
            }
            if viewModel.user?.role == .admin {
                NavigationStack {
                    clientsView
                }
                .tabItem {
                    Label("Clients", systemImage: "person")
                }
            }
            
            NavigationStack {
                shopView
            }
            .tabItem {
                Label("Shop", systemImage: "cart")
            }
        }
//        .toolbarColorScheme(.light, for: .tabBar)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dependencies: ModuleDependencies())
            .environmentObject(ModuleDependencies().loginViewModel())
    }
}
