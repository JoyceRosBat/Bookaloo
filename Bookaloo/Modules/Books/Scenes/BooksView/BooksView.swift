//
//  BooksView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BooksView: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    @State var showAlert: Bool = false
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            if viewModel.books.isEmpty {
                Text("**The list of books is empty.**\n\nTry to update again later")
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
                                price: book.price
                            )
                            .swipeActions(edge: .trailing,
                                          allowsFullSwipe: true) {
                                Button {
                                    viewModel.markAsRead(book)
                                } label: {
                                    Image(systemName: book.read == true ? .eye : .eyeSlash)
                                }
//                                .tint(book.read == true ? .accentColor : .gray)
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
                logoutConfirmationPopup
            }
        }//: Overlay - Show logout confirmation popup
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BookalooToolbarTitle()
            }//: ToolbarItem - Title
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    if let name = viewModel.user?.name {
                        Text("Welcome " + name)
                    }
                    if let email = viewModel.user?.email {
                        Text(email)
                    }
                    NavigationLink {
                        UserDataView(user: $viewModel.myUserToModify, isEditing: true, editingOwnUser: true)
                    } label: {
                        Label("Edit profile",
                              systemImage: .lock)
                    }
                    logoutOptionMenuButton
                } label: {
                    Label("Profile", systemImage: .personCircle)
                }//: Menu
            }//: ToolbarItem - User menu
        }//: Toolbar
    }
}

extension BooksView {
    @ViewBuilder
    var logoutOptionMenuButton: some View {
        Button {
            viewModel.alertTitle = "Warning"
            viewModel.alertMessage = "Are you sure you want to logout?"
            showAlert = true
        } label: {
            Label("Logout",
                  systemImage: .arrowTurnUpBackward)
        }
    }
    
    @ViewBuilder
    var logoutConfirmationPopup: some View {
        PopupView(
            showAlert: $showAlert,
            title: viewModel.alertTitle) {
                Text(viewModel.alertMessage)
            } buttons: {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Cancel")
                }
                Button {
                    viewModel.doLogout()
                    showAlert.toggle()
                } label: {
                    Text("Accept")
                }
            }
    }
}

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BooksView(dependencies: ModuleDependencies())
                .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
        }
    }
}