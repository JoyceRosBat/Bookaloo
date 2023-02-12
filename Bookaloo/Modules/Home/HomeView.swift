//
//  HomeView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct HomeView: View {
    let dependencies: CommonModulesDependenciesResolver
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var booksViewModel: BooksViewModel
    @EnvironmentObject var shopsViewModel: ShopViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                dependencies.booksView()
            }//: booksView NavigationStack
            .tabItem {
                Label("Books", systemImage: "book")
            }//: booksView tabItem
            
            if loginViewModel.isAdmin {
                NavigationStack {
                    dependencies.usersView()
                }//: UsersView NavigationStack
                .tabItem {
                    Label("Clients", systemImage: "person")
                }//: usersView tabItem
            }
            
            NavigationStack {
                dependencies.shopView()
            }//: shopView NavigationStack
            .tabItem {
                Label("Shop", systemImage: "cart")
            }//: shopView tabItem
            .badge(shopsViewModel.booksOrdered)
        }//: TabView
//        .toolbarColorScheme(.light, for: .tabBar)
        .onAppear {
            shopsViewModel.updateCart()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dependencies: ModuleDependencies())
            .environmentObject(ModuleDependencies().loginViewModel())
            .environmentObject(ModuleDependencies().booksViewModel())
    }
}
