//
//  LoginScreenView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 4/2/23.
//

import SwiftUI

struct LoginScreenView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                BookalooTextfield(
                    title: "Email: ",
                    textfieldText: $viewModel.email,
                    placeHolder: "Email"
                )
                
                BookalooTextfield(
                    title: "Password: ",
                    textfieldText: $viewModel.password,
                    placeHolder: "Password",
                    orientation: .horizontal(.secure))
                
                Button {
                    viewModel.doLogin()
                } label: {
                    Text("Login")
                        .font(.futura(24))
                }
                .buttonStyle(.bookalooStyle)
            }
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
