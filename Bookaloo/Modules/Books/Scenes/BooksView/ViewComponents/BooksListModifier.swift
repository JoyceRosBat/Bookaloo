//
//  BooksListModifier.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 27/2/23.
//

import SwiftUI

struct BooksListModifier: ViewModifier {
    @EnvironmentObject var viewModel: BooksViewModel
    @Binding var showAlert: Bool
    
    func body(content: Content) -> some View {
        content
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
