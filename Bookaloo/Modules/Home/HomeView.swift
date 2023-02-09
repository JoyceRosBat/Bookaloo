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
    
    var booksView: BooksView {
        dependencies.booksView()
    }
    var clientsView : ClientsView {
        dependencies.clientsView()
    }
    var shopView: ShopView {
        dependencies.shopView()
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                booksView
            }//: booksView NavigationStack
            .tabItem {
                Label("Books", systemImage: "book")
            }//: booksView tabItem
            
            if loginViewModel.isAdmin {
                NavigationStack {
                    clientsView
                }//: clientsView NavigationStack
                .tabItem {
                    Label("Clients", systemImage: "person")
                }//: clientsView tabItem
            }
            
            NavigationStack {
                shopView
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
