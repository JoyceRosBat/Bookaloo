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
    @Published var loggedIn: Bool = false
    let dependencies: LoginDependenciesResolver
    var loginUseCase: LoginUseCaseProtocol {
        dependencies.resolve()
    }
    
    init(dependencies: LoginDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    func doLogin() {
        guard !email.isEmpty,
              !password.isEmpty
        else {
            showError(with: "Ha ocurrido un error", message: "Debe introducir datos de usuario y contraseña")
            return
        }
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let user = User(email: self.email, password: self.password)
                let validated = try await self.loginUseCase.validate(user)
                Storage.shared.save(validated.email, key: .email)
                Storage.shared.save(validated.token, key: .token)
                await MainActor.run {
                    self.loggedIn = true
                }
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}
