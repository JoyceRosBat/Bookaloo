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
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Text("Books")
                Button(action: {
                    withAnimation{
                        viewModel.showAlert.toggle()
                    }
                }, label: {
                    Text("Botón")
                })
                .buttonStyle(.bookalooStyle)
            }
        }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().booksView()
    }
}
