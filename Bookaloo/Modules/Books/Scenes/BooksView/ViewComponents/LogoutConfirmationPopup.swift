//
//  LogoutConfirmationPopup.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 27/2/23.
//

import SwiftUI

struct LogoutConfirmationPopup: View {
    @EnvironmentObject var viewModel: BooksViewModel
    @Binding var showAlert: Bool
    
    var body: some View {
        PopupView(
            showAlert: $showAlert,
            title: LocalizedStringKey(viewModel.alertTitle)) {
                Text(LocalizedStringKey(viewModel.alertMessage))
            } buttons: {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("cancel")
                }
                Button {
                    viewModel.doLogout()
                    showAlert.toggle()
                } label: {
                    Text("accept")
                }
            }
    }
}
struct LogoutConfirmationPopup_Previews: PreviewProvider {
    static var previews: some View {
        LogoutConfirmationPopup(showAlert: .constant(false))
            .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
    }
}
