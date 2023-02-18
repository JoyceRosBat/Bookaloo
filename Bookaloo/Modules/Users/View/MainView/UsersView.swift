//
//  UsersView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import SwiftUI

struct UsersView: View {
    var dependencies: UsersDependenciesResolver
    
    var body: some View {
        VStack {
            Text("User Management")
                .font(.futura(24))
                .foregroundStyle(StyleConstants.bookalooGradient)
                .frame(height: 100)
            
            List {
                NavigationLink {
                    dependencies.modifyUserView()
                } label: {
                    Label("Find/Modify user", systemImage: "pencil.line")
                        .font(.futura(18))
                        .opacity(0.6)
                }//: Navigation to modify user
                .frame(height: 100)

                NavigationLink {
                    dependencies.createUserView()
                } label: {
                    Label("Create new user", systemImage: "person.badge.plus")
                        .font(.futura(18))
                        .opacity(0.6)
                }//: Navigation to create user
                .frame(height: 100)
                
            }//: List
            .scrollIndicators(.hidden)
        }//: VStack
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().usersView()
    }
}
