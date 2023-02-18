//
//  CreateUserView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 18/2/23.
//

import SwiftUI

struct CreateUserView: View {
    @EnvironmentObject var viewModel: UsersViewModel
    var action: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                Text("New user")
                    .font(.futura(24))
                    .bold()
                    .opacity(0.6)
            }//: HStack
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Email:")
                        .font(.futura(14))
                        .bold()
                        .foregroundColor(.accentColor)
                        .opacity(0.6)
                    
                    BookalooTextfield(
                        textfieldText: $viewModel.newUser.email,
                        valid: $viewModel.validEmail,
                        validationText: viewModel.validEmailText,
                        orientation: .horizontal(.email)
                    )//: Textfield
                }//: HStack - Email
                .padding(.horizontal, 16)
                
                HStack {
                    Text("Name:")
                        .font(.futura(14))
                        .bold()
                        .foregroundColor(.accentColor)
                        .opacity(0.6)
                    
                    BookalooTextfield(
                        textfieldText: $viewModel.newUser.name,
                        valid: $viewModel.emptyName,
                        validationText: viewModel.validNotEmptyText,
                        orientation: .horizontal(.normal)
                    )//: Textfield
                    
                }//: HStack - Name
                .padding(.horizontal, 16)
                
                HStack {
                    Text("Location:")
                        .font(.futura(14))
                        .bold()
                        .foregroundColor(.accentColor)
                        .opacity(0.6)
                    
                    BookalooTextfield(
                        textfieldText: $viewModel.newUser.location,
                        valid: $viewModel.emptyLocation,
                        validationText: viewModel.validNotEmptyText,
                        orientation: .horizontal(.normal)
                    )//: Textfield
                }//: HStack - Location
                .padding(.horizontal, 16)
            }//: VStack
            
            if viewModel.isAdmin {
                HStack {
                    Text("Role:")
                        .font(.futura(14))
                        .bold()
                        .foregroundColor(.accentColor)
                        .opacity(0.6)
                    
                    Picker(selection: $viewModel.newUser.role) {
                        ForEach(Role.allCases) { role in
                            Text(role.rawValue.capitalized)
                                .font(.futura(14))
                                .bold()
                                .opacity(0.7)
                        }
                    } label: {
                        Text("")
                    }//: Picker
                    
                }//: HStack - Role
                .padding(.horizontal, 16)
            }
            
            Spacer()
            
            Button {
                action?()
            } label: {
                Label("Save", systemImage: "square.and.arrow.down")
            }//: Button save
            .buttonStyle(.bookalooStyle)
            
        }//: VStack
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Bookaloo")
                    .font(.futura(24))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
            }//: ToolbarItem - Title
        }//: Toolbar
        .toolbar(.hidden, for: .tabBar)
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
            .environmentObject(ModuleDependencies().usersViewModel())
    }
}
