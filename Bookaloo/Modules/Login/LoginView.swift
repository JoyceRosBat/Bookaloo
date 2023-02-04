//
//  LoginView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import SwiftUI

struct LoginView: View {
    var dependencies: LoginDependenciesResolver
    @EnvironmentObject var viewModel: LoginViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        if viewModel.loggedIn {
            dependencies.homeView()
        } else {
            loginView
                .toolbar(.hidden, for: .tabBar)
        }
    }
}

extension LoginView {
    @ViewBuilder
    var loginView: some View {
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
                    placeHolder: "Email",
                    orientation: .horizontal(.email)
                )
                .focused($isFocused)
                
                BookalooTextfield(
                    title: "Password: ",
                    textfieldText: $viewModel.password,
                    valid: $viewModel.validPassword,
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().loginView()
    }
}
