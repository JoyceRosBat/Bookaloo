//
//  UserDataView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 16/2/23.
//

import SwiftUI

struct UserDataView: View {
    @Binding var user: UserModify
    @State var isEditing: Bool = false
    var action: (() -> Void)?
    
    var body: some View {
        if !user.email.isEmpty {
            VStack(spacing: 20) {
                HStack(alignment: .center) {
                    Text("User data")
                        .font(.futura(24))
                        .bold()
                        .opacity(0.6)
                    
                    Button {
                        isEditing.toggle()
                    } label: {
                        Image(systemName: "pencil.circle")
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
                    
                    if isEditing {
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
                        isEditing.toggle()
                        action?()
                    } label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }//: Button save
                    .buttonStyle(.bookalooStyle)
                }
            }//: VStack
        } else {
            EmptyView()
        }
    }
}

struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataView(user: .constant(.test))
    }
}
