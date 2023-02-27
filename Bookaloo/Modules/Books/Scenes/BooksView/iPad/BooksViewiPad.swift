//
//  BooksViewiPad.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 27/2/23.
//

import SwiftUI

public struct BooksViewiPad: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    @State var showAlert: Bool = false
    @State var bookSelected: Book?
    
    public var body: some View {
        NavigationSplitView {
            BooksList(dependencies: dependencies, showAlert: $showAlert, selected: $bookSelected)
        } detail: {
            let book = bookSelected != nil ? bookSelected : viewModel.books.first
            if let book {
                dependencies.resolve(book)
            }
        }
    }
}

struct BooksViewiPad_Previews: PreviewProvider {
    static var previews: some View {
        BooksViewiPad(dependencies: ModuleDependencies())
    }
}
