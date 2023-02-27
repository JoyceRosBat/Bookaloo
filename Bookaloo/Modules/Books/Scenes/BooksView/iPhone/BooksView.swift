//
//  BooksView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

public struct BooksView: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    @State var showAlert: Bool = false
    @State var bookSelected: Book?
    
    public var body: some View {
        ModifiedContent(
            content: BooksList(dependencies: dependencies, showAlert: $showAlert, selected: $bookSelected)
                .navigationDestination(for: Book.self) { book in
                    dependencies.resolve(book)
                },
            modifier: BooksListModifier(showAlert: $showAlert)
        )
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BooksView(dependencies: ModuleDependencies())
                .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
        }
    }
}
