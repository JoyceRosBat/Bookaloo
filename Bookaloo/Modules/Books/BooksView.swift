//
//  BooksView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import SwiftUI

struct BooksView: View {
    var dependencies: BooksDependenciesResolver
    @ObservedObject var viewModel: BooksViewModel
    
    var body: some View {
        Group {
            if viewModel.loggedIn {
                booksView
            } else {
                dependencies.loginView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
    }
}

extension BooksView {
    @ViewBuilder
    var booksView: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Text("Books")
                Button(action: {
                    withAnimation{
                        viewModel.showAlert.toggle()
                    }
                }, label: {
                    Text("Botón")
                })
                .buttonStyle(.bookalooStyle)
            }
        }
        .overlay {
            logoutConfirmationPopup
        }
        .toolbar {
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
                }
            }
        }
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

struct BooksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ModuleDependencies().booksView()
        }
    }
}
