//
//  LoginView.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import SwiftUI

struct LoginView: View {
    var dependencies: LoginDependenciesResolver
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        if viewModel.loggedIn {
            dependencies.homeView()
        } else {
            dependencies.loginContentView()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().loginView()
    }
}