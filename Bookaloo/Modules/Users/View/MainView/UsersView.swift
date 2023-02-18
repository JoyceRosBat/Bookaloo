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
        VStack(spacing: 0) {
            Text("User Management")
                .font(.futura(24))
                .foregroundStyle(StyleConstants.bookalooGradient)

            Color(uiColor: .systemGroupedBackground)
            
            List {
                NavigationLink {
                    dependencies.modifyUserView()
                } label: {
                    Label("Find/Modify user", systemImage: "pencil.line")
                }//: Navigation to modify user
                .frame(height: 50)

                NavigationLink {
                    //TODO: Create new user
                } label: {
                    Label("Create new user", systemImage: "person.badge.plus")
                }//: Navigation to create user
                .frame(height: 50)
                
            }//: List
            
            Color(uiColor: .systemGroupedBackground)
        }//: VStack
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().usersView()
    }
}
