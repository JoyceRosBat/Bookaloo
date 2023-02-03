//
//  LoginView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import SwiftUI

struct LoginView: View {
    var dependencies: LoginDependenciesResolver
    @ObservedObject var viewModel: LoginViewModel
    @State var isSecure: Bool = true
    
    var body: some View {
        NavigationStack {
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

                    NavigationLink {
                        if viewModel.loggedIn {
                            dependencies.homeView()
                        }
                    } label: {
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
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().loginView()
    }
}
