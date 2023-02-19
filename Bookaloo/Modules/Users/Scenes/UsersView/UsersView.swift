//
//  UsersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct UsersView: View {
    var dependencies: UsersDependenciesResolver
    var modifyUserView: ModifyUserView {
        dependencies.resolve()
    }
    var createUserView: CreateUserView {
        dependencies.resolve()
    }
    
    var body: some View {
        VStack {
            Text("user_management_header_title")
                .font(.futura(24))
                .bold()
                .foregroundStyle(StyleConstants.bookalooGradient)
                .padding()
            
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                VStack {
                    List {
                        NavigationLink {
                            modifyUserView
                        } label: {
                            Label("find_user", systemImage: .pencilLine)
                                .font(.futura(18))
                                .opacity(0.6)
                        }//: Navigation to modify user
                        .frame(height: 100)

                        NavigationLink {
                            createUserView
                        } label: {
                            Label("create_user", systemImage: .addPerson)
                                .font(.futura(18))
                                .opacity(0.6)
                        }//: Navigation to create user
                        .frame(height: 100)
                        
                    }//: List
                    .scrollIndicators(.hidden)
                    .padding(.top, 40)
                }//: VStack
            }//: ZStack
        }//: VStack
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().resolve() as UsersView
    }
}
