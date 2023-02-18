//
//  LoginView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import SwiftUI

struct LoginHomeView: View {
    var dependencies: LoginDependenciesResolver
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        if viewModel.loggedIn {
            dependencies.homeView()
        } else {
            NavigationStack {
                dependencies.loginView()
            }
        }
    }
}

struct LoginHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().loginHomeView()
    }
}
