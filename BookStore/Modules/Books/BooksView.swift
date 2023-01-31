//
//  BooksView.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var viewModel: BooksViewModel
    
    var body: some View {
        Text("Books")
            .onAppear {
                viewModel.fetchBooks()
            }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().booksView()
    }
}
