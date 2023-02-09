//
//  PurchasedBooksList.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 12/2/23.
//

import SwiftUI

struct PurchasedBooksList: View {
    @EnvironmentObject var booksViewModel: BooksViewModel
    @State var books: [Int]?
    
    var body: some View {
        ForEach(Array(Set(books ?? [])), id: \.self) { bookId in
            if let book = booksViewModel.books.first(where: { $0.id == bookId }) {
                HStack(alignment: .top) {
                    Text(Image(systemName: "book"))
                        .foregroundStyle(StyleConstants.bookalooGradient)
                        .bold()
                    Text("\(book.title):")
                    Text("\(books?.filter { $0 == bookId }.count ?? 0)")
                        .bold()
                }
            }
        }
    }
}

struct PurchasedBooksList_Previews: PreviewProvider {
    static var previews: some View {
        PurchasedBooksList(books: [1,1,2,5,3,2,6,8])
            .environmentObject(ModuleDependencies().booksViewModel())
    }
}
