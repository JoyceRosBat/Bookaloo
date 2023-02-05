//
//  BooksView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct BooksView: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        Group {
            if viewModel.loggedIn {
                dependencies.booksContentView()
            } else {
                dependencies.loginView()
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ModuleDependencies().booksView()
        }
    }
}
