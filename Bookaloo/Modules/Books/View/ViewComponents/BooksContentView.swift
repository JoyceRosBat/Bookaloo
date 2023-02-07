//
//  BooksContentView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct BooksContentView: View {
    var dependencies: BooksDependenciesResolver
    @EnvironmentObject var viewModel: BooksViewModel
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            List {
                ForEach(viewModel.filteredBooks) { book in
                    NavigationLink(value: book) {
                        BookCellView(
                            imageURL: book.cover,
                            title: book.title,
                            author: book.author,
                            year: book.year
                        )
                    }//: NavigationLink
                }//: ForEach
            }//: List
        }//: BaseViewContent
        .navigationDestination(for: Book.self) { book in
            dependencies.bookDetailsView(book)
        }//: navigationDestination
        .searchable(text: $viewModel.searchText)
        .toolbar(viewModel.showAlert ? .hidden : .visible, for: .tabBar)
        .overlay {
            if viewModel.showAlert {
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

extension BooksContentView {
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
            viewModel.showAlert = true
        } label: {
            Label("Logout",
                  systemImage: "arrowshape.turn.up.backward")
        }
    }
    
    @ViewBuilder
    var logoutConfirmationPopup: some View {
        PopupView(showAlert: $viewModel.showAlert,
                  title: viewModel.alertTitle,
                  message: viewModel.alertMessage) {
            Button {
                viewModel.showAlert.toggle()
            } label: {
                Text("Cancel")
            }
            Button {
                viewModel.doLogout()
                viewModel.showAlert.toggle()
            } label: {
                Text("Accept")
            }
        }
    }
}

struct BooksContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BooksContentView(dependencies: ModuleDependencies())
                .environmentObject(ModuleDependencies().booksViewModel())
        }
    }
}
