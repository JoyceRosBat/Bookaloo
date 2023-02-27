//
//  BooksList.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 27/2/23.
//

import SwiftUI

struct BooksList: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    @Binding var showAlert: Bool
    @Binding var selected: Book?
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            if viewModel.books.isEmpty {
                Text("books_empty_list")
                    .emptyMessageModifier()
            } else {
                List {
                    ForEach(viewModel.filteredBooks) { book in
                        NavigationLink(value: book) {
                            BookCellView(
                                imageURL: book.cover,
                                title: book.title,
                                author: book.author,
                                year: book.year,
                                rating: book.rating,
                                purchased: book.purchased ?? false,
                                read: book.read ?? false,
                                price: book.price,
                                showRating: true
                            )
                            .swipeActions(edge: .trailing,
                                          allowsFullSwipe: true) {
                                Button {
                                    viewModel.markAsRead(book)
                                } label: {
                                    Image(systemName: book.read == true ? .eye : .eyeSlash)
                                }
                            }
                                          .onTapGesture {
                                              selected = book
                                          }
                        }//: NavigationLink
                    }//: ForEach
                    
                }//: List
                .refreshable {
                    viewModel.getBooks(removingCache: true)
                }
                .scrollIndicators(.hidden)
            }//: If list of books is not empty
        }//: BaseViewContent
    }
}

struct BooksList_Previews: PreviewProvider {
    static var previews: some View {
        BooksList(dependencies: ModuleDependencies(), showAlert: .constant(false), selected: .constant(.test))
            .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
    }
}
