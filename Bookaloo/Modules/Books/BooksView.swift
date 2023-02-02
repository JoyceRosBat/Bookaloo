//
//  BooksView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct BooksView: View {
    @ObservedObject var viewModel: BooksViewModel
    
    var body: some View {
        VStack {
            Text("Books")
            Button(action: {
                
            }, label: {
                Text("Botón")
            })
            .buttonStyle(.bookalooStyle)
        }
        .onAppear {
            viewModel.fetchBooks()
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies.shared.booksView()
    }
}
