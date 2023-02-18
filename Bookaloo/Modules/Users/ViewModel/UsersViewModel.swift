//
//  UsersViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

final class UsersViewModel: ObservableBaseViewModel {
    let dependencies: UsersDependenciesResolver
    var usersUseCase: UsersUseCaseProtocol {
        dependencies.resolve()
    }
    
    @Published var userFound: UserData = UserData(email: "", name: "", location: "", role: .user)
    @Published var newUser: UserData = UserData(email: "", name: "", location: "", role: .user)
    @Published var validEmail: Bool = true
    @Published var emptyName: Bool = false
    @Published var emptyLocation: Bool = false
    @Published var validEmailText: String = "The email format is not valid. Exmple: something@email.com"
    @Published var validNotEmptyText: String = "This field should not be empty."
    
    init(dependencies: UsersDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    /// Get user's data
    /// ```
    ///        usersUseCase.getUserData()
    /// ```
    func getUserData() {
        guard let email = user?.email else { return }
        getUserData(with: email)
    }
    
    /// Get a user's data by its email
    /// ```
    ///        usersUseCase.findUser("email")
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to find
    func findUser(by email: String) {
        getUserData(with: email)
    }
    
    /// Modify user's data
    /// ```
    ///        usersUseCase.modify()
    /// ```
    func modify() {
        Task {
            showLoading(true)
            let user = User(email: userFound.email, name: userFound.name, location: userFound.location, role: userFound.role)
            do {
                try await usersUseCase.modify(user)
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}

private extension UsersViewModel {
    func getUserData(with email: String) {
        Task {
            do {
                showLoading(true)
                let userFound = try await usersUseCase.find(by: email)
                
                await MainActor.run {
                    self.userFound = UserData(
                        email: userFound.email,
                        name: userFound.name ?? "",
                        location: userFound.location ?? "",
                        role: userFound.role ?? .user
                    )
                }
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}
