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
    var loginHomeView: LoginHomeView {
        dependencies.resolve()
    }
    var booksView: BooksView {
        dependencies.resolve()
    }
    
    var body: some View {
        if viewModel.loggedIn {
            booksView
        } else {
            loginHomeView
        }
    }
}

struct BooksHomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ModuleDependencies().resolve() as BooksHomeView
        }
    }
}
