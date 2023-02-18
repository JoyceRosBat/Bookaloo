//
//  LoginContentView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        BaseViewContent(viewModel: viewModel) {
            VStack {
                Image("fairytale_book")
                    .imageModifier()
                    .frame(width: 100)
                
                Text("Bookaloo")
                    .font(.futura(48))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
                    
                BookalooTextfield(
                    textfieldText: $viewModel.email,
                    valid: $viewModel.validEmail,
                    validationText: viewModel.validEmailText,
                    placeHolder: "Email",
                    orientation: .vertical(.email)
                )//: TexField
                .focused($isFocused)
                
                BookalooTextfield(
                    textfieldText: $viewModel.password,
                    valid: $viewModel.validPassword,
                    validationText: viewModel.validPasswordText,
                    placeHolder: "Password",
                    orientation: .vertical(.secure)
                )//: TexField
                .focused($isFocused)
                
                Button {
                    viewModel.doLogin()
                } label: {
                    Text("Login")
                        .font(.futura(24))
                }//: Button
                .buttonStyle(.bookalooStyle)
                
                Spacer()
                
            }//: VStack
            .padding(.top, 100)
        }//: BaseViewContent
        .onTapGesture {
            isFocused = false
        }//: onTapGesture
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ModuleDependencies().loginViewModel())
    }
}
