//
//  LoginViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

final class LoginViewModel: ObservableBaseViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var validEmail: Bool = true
    @Published var validPassword: Bool = true
    @Published var validEmailText: String = "The email format is not valid. Exmple: something@email.com"
    @Published var validPasswordText: String = "The password should have 8 characters or more"
    
    let dependencies: LoginDependenciesResolver
    var loginUseCase: LoginUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: LoginDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    /// Validates if user and password are correct and try to login
    /// ```
    ///        viewModel.doLogin()
    /// ```
    func doLogin() {
        validEmail = email.isValidEmail
        validPassword = password.count >= 8
        
        guard validEmail, validPassword else { return }
        showLoading(true)
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let user = User(email: self.email, password: self.password)
                let validated = try await self.loginUseCase.validate(user)
                
                Storage.shared.save(validated, key: .user)
                
                self.showLoading(false)
                await MainActor.run {
                    self.email = ""
                    self.password = ""
                    myUserToModify = UserData(email: self.user?.email ?? "", name: self.user?.name ?? "", location: self.user?.location ?? "", role: self.user?.role ?? .user)
                }
            } catch let error as NetworkError {
                self.showNetworkError(error)
            }
        }
    }
}
