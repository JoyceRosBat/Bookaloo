//
//  LoginContentView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct LoginContentView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Text("Bookaloo")
                    .font(.futura(48))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
                    
                BookalooTextfield(
                    title: "Email: ",
                    textfieldText: $viewModel.email,
                    valid: $viewModel.validEmail,
                    validationText: viewModel.validEmailText,
                    placeHolder: "Email",
                    orientation: .horizontal(.email)
                )
                .focused($isFocused)
                
                BookalooTextfield(
                    title: "Password: ",
                    textfieldText: $viewModel.password,
                    valid: $viewModel.validPassword,
                    validationText: viewModel.validPasswordText,
                    placeHolder: "Password",
                    orientation: .horizontal(.secure))
                .focused($isFocused)
                
                Button {
                    viewModel.doLogin()
                } label: {
                    Text("Login")
                        .font(.futura(24))
                }
                .buttonStyle(.bookalooStyle)
            }
        }
        .onTapGesture {
            isFocused = false
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView()
    }
}
