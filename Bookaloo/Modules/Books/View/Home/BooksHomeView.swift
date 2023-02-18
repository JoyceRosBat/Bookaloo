//
//  BooksHomeView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct BooksHomeView: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        if viewModel.loggedIn {
            dependencies.booksView()
        } else {
            dependencies.loginView()
        }
    }
}

struct BooksHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ModuleDependencies().booksHomeView()
        }
    }
}
