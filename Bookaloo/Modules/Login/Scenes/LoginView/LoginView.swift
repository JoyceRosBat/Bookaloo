//
//  LoginContentView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import SwiftUI

public struct LoginView: View {
    var dependencies: LoginDependenciesResolver
    @EnvironmentObject var viewModel: LoginViewModel
    @FocusState private var isFocused: Bool
    var createUserView: CreateUserView {
        dependencies.resolve()
    }
    
    public var body: some View {
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
                    placeHolder: "email",
                    orientation: .vertical(.email)
                )//: TexField
                .focused($isFocused)
                
                BookalooTextfield(
                    textfieldText: $viewModel.password,
                    valid: $viewModel.validPassword,
                    validationText: viewModel.validPasswordText,
                    placeHolder: "password",
                    orientation: .vertical(.secure)
                )//: TexField
                .focused($isFocused)
                
                Button {
                    viewModel.doLogin()
                } label: {
                    Text("login")
                        .font(.futura(24))
                }//: Button
                .buttonStyle(.bookalooStyle)
                
                Spacer()
                
                NavigationLink {
                    createUserView
                } label: {
                    Label("not_user_button", systemImage: .addPerson)
                        .font(StyleConstants.bookalooFont)
                        .foregroundColor(.accentColor)
                }
                
                Spacer(minLength: 20)
                
            }//: VStack
            .padding(.top, 100)
        }//: BaseViewContent
        .onTapGesture {
            isFocused = false
        }//: onTapGesture
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea(.all)
        .onDisappear {
            viewModel.resetValidStatus()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(dependencies: ModuleDependencies())
            .environmentObject(ModuleDependencies().resolve() as LoginViewModel)
    }
}
