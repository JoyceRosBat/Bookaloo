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
            if let book = booksViewModel.books.first(where: { $0.apiID == bookId }) {
                HStack(alignment: .center) {
                    Text(Image(systemName: .book))
                        .foregroundStyle(StyleConstants.bookalooGradient)
                        .bold()
                        .font(.futura(12))
                    
                    Text("\(book.title):")
                        .font(.futura(12))
                        .opacity(0.7)
                    
                    Text("\(books?.filter { $0 == bookId }.count ?? 0)")
                        .bold()
                        .font(.futura(10))
                        .opacity(0.7)
                }
            }
        }
    }
}

struct PurchasedBooksList_Previews: PreviewProvider {
    static var previews: some View {
        PurchasedBooksList(books: [1,1,2,5,3,2,6,8])
            .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
    }
}
