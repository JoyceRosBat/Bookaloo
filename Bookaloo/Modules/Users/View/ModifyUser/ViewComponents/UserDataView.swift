//
//  UserDataView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 16/2/23.
//

import SwiftUI

struct UserDataView: View {
    @EnvironmentObject var viewModel: UsersViewModel
    @Binding var user: UserData
    @State var isEditing: Bool = false
    @State var editingOwnUser: Bool = false
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundColor
                .ignoresSafeArea()
            if !user.email.isEmpty {
                VStack(spacing: 20) {
                    HStack(alignment: .center) {
                        Text("User data")
                            .font(.futura(24))
                            .bold()
                            .opacity(0.6)
                        
                        if !editingOwnUser {
                            Button {
                                isEditing.toggle()
                            } label: {
                                Image(systemName: .pencilCircle)
                            }
                        }
                    }//: HStack
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Email:")
                                .font(.futura(14))
                                .bold()
                                .foregroundColor(.accentColor)
                                .opacity(0.6)
                            
                            Text(user.email)
                                .font(.futura(14))
                                .bold()
                                .opacity(0.6)
                        }//: HStack - Email
                        .padding(.horizontal, 16)
                        
                        HStack {
                            Text("Name:")
                                .font(.futura(14))
                                .bold()
                                .foregroundColor(.accentColor)
                                .opacity(0.6)
                            
                            if isEditing {
                                BookalooTextfield(textfieldText: $user.name)
                                    .focused($isFocused)
                            } else {
                                Text(user.name)
                                    .font(.futura(14))
                                    .bold()
                                    .opacity(0.6)
                            }
                        }//: HStack - Name
                        .padding(.horizontal, 16)
                        
                        HStack {
                            Text("Location:")
                                .font(.futura(14))
                                .bold()
                                .foregroundColor(.accentColor)
                                .opacity(0.6)
                            
                            if isEditing {
                                BookalooTextfield(textfieldText: $user.location)
                                    .focused($isFocused)
                            } else {
                                Text(user.location)
                                    .font(.futura(14))
                                    .bold()
                                    .opacity(0.6)
                            }
                        }//: HStack - Location
                        .padding(.horizontal, 16)
                    }//: VStack
                    
                    HStack {
                        Text("Role:")
                            .font(.futura(14))
                            .bold()
                            .foregroundColor(.accentColor)
                            .opacity(0.6)
                        
                        if isEditing, !editingOwnUser {
                            Picker(selection: $user.role) {
                                ForEach(Role.allCases) { role in
                                    Text(role.rawValue.capitalized)
                                        .font(.futura(14))
                                        .bold()
                                        .opacity(0.7)
                                }
                            } label: {
                                Text("")
                            }//: Picker
                        } else {
                            Text(user.role.rawValue.capitalized)
                                .font(.futura(14))
                                .bold()
                                .opacity(0.6)
                        }
                    }//: HStack - Role
                    .padding(.horizontal, 16)
                    
                    if isEditing {
                        Button {
                            if !editingOwnUser {
                                isEditing.toggle()
                            }
                            viewModel.modify(user)
                        } label: {
                            Label("Save", systemImage: .squareArrowDown)
                        }//: Button save
                        .buttonStyle(.bookalooStyle)
                    }
                }//: VStack
                .onTapGesture {
                    isFocused = false
                }//: onTapGesture
                .toolbar(.hidden, for: .tabBar)
            }//If user email is not empty
        }//: ZStack
        .overlay {
            if viewModel.showModifiedUserAlert {
                userModifiedPopup
                    .ignoresSafeArea()
            }
        }
    }
}

extension UserDataView {
    @ViewBuilder
    var userModifiedPopup: some View {
        PopupView(
            showAlert: $viewModel.showModifiedUserAlert,
            title: "User modified") {
                Text("User modified successfully")
            } buttons: {
                Button {
                    viewModel.showModifiedUserAlert.toggle()
                } label: {
                    Text("Accept")
                }
            }
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataView(user: .constant(.test))
            .environmentObject(ModuleDependencies().usersViewModel())
    }
}
