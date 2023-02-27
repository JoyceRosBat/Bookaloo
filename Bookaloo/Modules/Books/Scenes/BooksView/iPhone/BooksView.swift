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
        BooksList(dependencies: dependencies, showAlert: $showAlert, selected: $bookSelected)
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
