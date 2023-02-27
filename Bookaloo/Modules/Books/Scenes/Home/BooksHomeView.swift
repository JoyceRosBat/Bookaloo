//
//  BooksHomeView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

public struct BooksHomeView: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    var loginHomeView: LoginHomeView {
        dependencies.resolve()
    }
    var booksView: BooksView {
        dependencies.resolve()
    }
    var booksViewiPad: BooksViewiPad {
        dependencies.resolve()
    }
    
    public var body: some View {
        if viewModel.loggedIn {
            if UIDevice.current.userInterfaceIdiom == .pad {
                booksViewiPad
            } else {
                booksView
            }
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
