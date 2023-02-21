//
//  BookShopCell.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 9/2/23.
//

import SwiftUI

struct BookShopCell: View {
    @EnvironmentObject var viewModel: ShopViewModel
    @State var book: Book
    @State var bookId: Int
    @State var quantity: Int
    @Binding var showAlert: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    BookCellView(
                        imageURL: book.cover,
                        title: book.title,
                        author: book.author,
                        year: book.year,
                        rating: book.rating,
                        purchased: false,
                        read: false,
                        price: book.price
                    )
                    
                    Spacer()
                    
                    Button {
                        Task {
                            await MainActor.run {
                                showAlert = true
                                viewModel.bookSelected = book
                            }
                        }
                    } label: {
                        Image(systemName: .trash)
                    }
                }
                
                HStack {
                    Stepper {
                        Text(String(quantity))
                    } onIncrement: {
                        if quantity < 10 {
                            quantity += 1
                            viewModel.addToCart(book)
                        }
                    } onDecrement: {
                        if quantity > 1 {
                            quantity -= 1
                            viewModel.removeFromCart(book)
                        } else {
                            viewModel.bookSelected = book
                            showAlert = true
                        }
                    }//: Stepper
                }//: Hstack

            }//: VStack
        }//: ZStack
    }
}

struct BookShopCell_Previews: PreviewProvider {
    static var previews: some View {
        BookShopCell(book: .test, bookId: 1, quantity: 2, showAlert: .constant(false))
            .environmentObject(ModuleDependencies().resolve() as ShopViewModel)
    }
}
