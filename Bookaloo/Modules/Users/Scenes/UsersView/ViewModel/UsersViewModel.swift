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
    @Published var validName: Bool = true
    @Published var validLocation: Bool = true
    @Published var validEmailText: String = "valid_email_text"
    @Published var validNotEmptyText: String = "valid_empty_text"
    @Published var showCreatedUserAlert: Bool = false
    @Published var showModifiedUserAlert: Bool = false
    
    init(dependencies: UsersDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    override func onAppear() {
        super.onAppear()
        cleanUserFound()
    }
    
    /// Get user's data
    /// ```
    ///        usersUseCase.getUserData()
    /// ```
    @MainActor
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
    @MainActor
    func findUser(by email: String) {
        getUserData(with: email)
    }
    
    /// Modify user's data
    /// ```
    ///        usersUseCase.modify()
    /// ```
    @MainActor
    func modify(_ userData: UserData) {
        Task {
            showLoading(true)
            let user = User(email: userData.email, name: userData.name, location: userData.location, role: userData.role)
            do {
                try await usersUseCase.modify(user)
                showLoading(false)
                showModifiedUserAlert = true
                if user.email == self.user?.email {
                    Storage.shared.save(user, key: .user)
                }
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Saves new user
    /// ```
    ///        usersUseCase.save()
    /// ```
    @MainActor
    func save() {
        validEmail = newUser.email.isValidEmail
        validName = !newUser.name.isEmpty
        validLocation = !newUser.location.isEmpty
        
        guard validEmail, validName, validLocation else { return }
        
        Task {
            showLoading(true)
            let user = User(email: newUser.email, name: newUser.name, location: newUser.location, role: newUser.role)
            do {
                try await usersUseCase.new(user)
                showLoading(false)
                newUser = UserData(email: "", name: "", location: "", role: .user)
                showCreatedUserAlert = true
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}

private extension UsersViewModel {
    @MainActor
    func getUserData(with email: String) {
        Task {
            do {
                showLoading(true)
                let userFound = try await usersUseCase.find(by: email)
                
                self.userFound = UserData(
                    email: userFound.email,
                    name: userFound.name ?? "",
                    location: userFound.location ?? "",
                    role: userFound.role ?? .user
                )
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    func cleanUserFound() {
        userFound = UserData(email: "", name: "", location: "", role: .user)
    }
}
