//
//  HomeView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

public struct HomeView: View {
    let dependencies: CommonModulesDependenciesResolver
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var shopsViewModel: ShopViewModel
    var shopView: ShopView {
        dependencies.resolve()
    }
    var usersView: UsersView {
        dependencies.resolve()
    }
    var booksHomeView: BooksHomeView {
        dependencies.resolve()
    }
    var handleOrdersView: HandleOrdersView {
        dependencies.resolve()
    }
    
    public var body: some View {
        TabView {
            NavigationStack {
                booksHomeView
                    .toolbarBackground(
                        Color.backgroundColor,
                        for: .tabBar
                    )
                    .toolbarBackground(
                        .visible,
                        for: .tabBar
                    )
            }//: booksView NavigationStack
            .tabItem {
                Label("books", systemImage: .book)
            }//: booksView tabItem
            
            if loginViewModel.isAdmin {
                NavigationStack {
                    usersView
                }//: UsersView NavigationStack
                .tabItem {
                    Label("clients", systemImage: .person)
                }//: usersView tabItem
            }
            
            NavigationStack {
                shopView
                    .toolbarBackground(
                        Color.backgroundColor,
                        for: .navigationBar
                    )
                    .toolbarBackground(
                        .visible,
                        for: .navigationBar
                    )
                    .toolbarBackground(
                        Color.backgroundColor,
                        for: .tabBar
                    )
                    .toolbarBackground(
                        .visible,
                        for: .tabBar
                    )
            }//: shopView NavigationStack
            .tabItem {
                Label("shop", systemImage: .cart)
            }//: shopView tabItem
            .badge(shopsViewModel.booksOrdered)
            
            if loginViewModel.isAdmin {
                NavigationStack {
                    handleOrdersView
                }
                .tabItem {
                    Label("orders", systemImage: .trayAndArrowDownFill)
                }//: Handle orders
            }
            
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
            .environmentObject(ModuleDependencies().resolve() as LoginViewModel)
            .environmentObject(ModuleDependencies().resolve() as ShopViewModel)
    }
}
