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
        .navigationDestination(for: Book.self) { book in
            dependencies.resolve(book)
        }//: navigationDestination
        .searchable(text: $viewModel.searchText)
        .toolbar(showAlert ? .hidden : .visible, for: .tabBar)
        .overlay {
            if showAlert {
                LogoutConfirmationPopup(showAlert: $showAlert)
            }
        }//: Overlay - Show logout confirmation popup
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BookalooToolbarTitle()
            }//: ToolbarItem - Title
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    if let name = viewModel.user?.name {
                        Text(String(format: NSLocalizedString("welcome", comment: ""), name))
                    }
                    if let email = viewModel.user?.email {
                        Text(email)
                    }
                    NavigationLink {
                        UserDataView(user: $viewModel.myUserToModify, isEditing: true, editingOwnUser: true)
                    } label: {
                        Label("edit_profile",
                              systemImage: .lock)
                    }
                    LogoutOptionMenu(showAlert: $showAlert)
                } label: {
                    Label("profile", systemImage: .personCircle)
                }//: Menu
            }//: ToolbarItem - User menu
        }//: Toolbar
    }
}

struct BooksList_Previews: PreviewProvider {
    static var previews: some View {
        BooksList(dependencies: ModuleDependencies(), showAlert: .constant(false), selected: .constant(.test))
            .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
    }
}
