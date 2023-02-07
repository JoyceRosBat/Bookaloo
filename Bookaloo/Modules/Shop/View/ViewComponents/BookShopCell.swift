//
//  BookShopCell.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 9/2/23.
//

import SwiftUI

struct BookShopCell: View {
    @EnvironmentObject var booksViewModel: BooksViewModel
    @State var book: Book
    @State var bookId: Int
    @State var quantity: Int
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                BookCellView(
                    imageURL: book.cover,
                    title: book.title,
                    author: book.author,
                    year: book.year
                )
                
                HStack {
                    Text(String(quantity))
                }//: HStack
                
                Stepper(String(quantity), value: $quantity, in: 1...10) { changed in
                    // Todo: Add or not books to order....
                }
            }//: VStack
        }//: ZStack
    }
}

struct BookShopCell_Previews: PreviewProvider {
    static var previews: some View {
        BookShopCell(book: .test, bookId: 1, quantity: 2)
            .environmentObject(ModuleDependencies().booksViewModel())
    }
}
