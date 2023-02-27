//
//  LogoutOptionMenu.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 27/2/23.
//

import SwiftUI

struct LogoutOptionMenu: View {
    @EnvironmentObject var viewModel: BooksViewModel
    @Binding var showAlert: Bool
    
    var body: some View {
        Button {
            viewModel.alertTitle = "logout_warning_popup_title"
            viewModel.alertMessage = "logout_warning_popup_message"
            showAlert = true
        } label: {
            Label("logout",
                  systemImage: .arrowTurnUpBackward)
        }
    }
}

struct LogoutOptionMenu_Previews: PreviewProvider {
    static var previews: some View {
        LogoutOptionMenu(showAlert: .constant(false))
            .environmentObject(ModuleDependencies().resolve() as BooksViewModel)
    }
}
