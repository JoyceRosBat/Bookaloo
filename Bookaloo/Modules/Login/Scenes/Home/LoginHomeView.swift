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
    var loginView: LoginView {
        dependencies.resolve()
    }
    var homeView: HomeView {
        dependencies.resolve()
    }
    
    var body: some View {
        if viewModel.loggedIn {
            homeView
        } else {
            NavigationStack {
                loginView
            }
        }
    }
}

struct LoginHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleDependencies().resolve() as LoginHomeView
    }
}
