//
//  ShopView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject var booksViewModel: BooksViewModel
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            if booksViewModel.booksToShop.isEmpty {
                Text("**There are no books ordered yet.**\n\nSelect a book and press *Shop* button to order one.")
                    .font(.futura(24))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(StyleConstants.bookalooGradient)
                    .padding(16)
            } else {
                List {
                    ForEach(booksViewModel.booksToShop.sorted(by: >), id: \.key) { bookId, quantity in
                        if let book = booksViewModel.books.first(where: { $0.id == bookId }) {
                            BookShopCell(book: book, bookId: bookId, quantity: quantity)
                        }//: If book found...
                    }//: ForEach
                }//: List
            }//: If books to shop is not empty
        }//: BaseViewContent
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().shopView()
            .environmentObject(ModuleDependencies().booksViewModel())
    }
}
