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
                                    book.read == true ? Image(systemName: "eye") : Image(systemName: "eye.slash")
                                }
                                //                                .tint(book.read == true ? .accentColor : .gray)
                            }
                        }//: NavigationLink
                    }//: ForEach
                    
                }//: List
                .refreshable {
                    viewModel.getBooks()
                }
            }//: If list of books is not empty
        }//: BaseViewContent
        .navigationDestination(for: Book.self) { book in
            dependencies.bookDetailsView(book)
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
                Text("Bookaloo")
                    .font(.futura(24))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
            }//: ToolbarItem - Title
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    if let name = viewModel.user?.name {
                        Text("Welcome " + name)
                    }
                    if let email = viewModel.user?.email {
                        Text(email)
                    }
                    profileOptionMenuButton
                    logoutOptionMenuButton
                } label: {
                    Label("Profile", systemImage: "person.crop.circle")
                }//: Menu
            }//: ToolbarItem - User menu
        }//: Toolbar
    }
}

extension BooksView {
    @ViewBuilder
    var profileOptionMenuButton: some View {
        Button {
            
        } label: {
            Label("Edit profile",
                  systemImage: "lock")
        }
    }
    
    @ViewBuilder
    var logoutOptionMenuButton: some View {
        Button {
            viewModel.alertTitle = "Warning"
            viewModel.alertMessage = "Are you sure you want to logout?"
            showAlert = true
        } label: {
            Label("Logout",
                  systemImage: "arrowshape.turn.up.backward")
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
                .environmentObject(ModuleDependencies().booksViewModel())
        }
    }
}
