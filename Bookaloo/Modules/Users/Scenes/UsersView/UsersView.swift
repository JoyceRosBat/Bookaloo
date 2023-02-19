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
        ZStack {
            Color(uiColor: .systemGroupedBackground)
            VStack {
                List {
                    NavigationLink {
                        modifyUserView
                    } label: {
                        Label("Find/Modify user", systemImage: .pencilLine)
                            .font(.futura(18))
                            .opacity(0.6)
                    }//: Navigation to modify user
                    .frame(height: 100)

                    NavigationLink {
                        createUserView
                    } label: {
                        Label("Create new user", systemImage: .addPerson)
                            .font(.futura(18))
                            .opacity(0.6)
                    }//: Navigation to create user
                    .frame(height: 100)
                    
                }//: List
                .scrollIndicators(.hidden)
                .padding(.top, 40)
            }//: VStack
        }//: ZStack
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("User Management")
                    .font(.futura(32))
                    .bold()
                    .foregroundStyle(StyleConstants.bookalooGradient)
                    .padding()
            }//: ToolbarItem - Title
        }//: Toolbar
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().resolve() as UsersView
    }
}
