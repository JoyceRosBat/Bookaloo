//
//  UsersViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

public final class UsersViewModel: ObservableBaseViewModel {
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
    
    public init(dependencies: UsersDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    public override func onAppear() {
        super.onAppear()
        cleanUserFound()
    }
    
    /// Get user's data
    /// ```
    ///        viewModel.getUserData()
    /// ```
    @MainActor
    func getUserData() {
        guard let email = user?.email else { return }
        getUserData(with: email)
    }
    
    /// Get a user's data by its email
    /// ```
    ///        viewModel.findUser("email")
    /// ```
    /// - Parameters:
    ///   - email: Email of the user to find
    @MainActor
    func findUser(by email: String) {
        getUserData(with: email)
    }
    
    /// Modify user's data
    /// ```
    ///        viewModel.modify()
    /// ```
    @MainActor
    func modify(_ userData: UserData) {
        Task { [weak self] in
            guard let self = self else { return }
            showLoading(true)
            let user = User(email: userData.email, name: userData.name, location: userData.location, role: userData.role)
            do {
                try await self.usersUseCase.modify(user)
                self.showLoading(false)
                self.showModifiedUserAlert = true
                if user.email == self.user?.email {
                    Storage.shared.save(user, key: .user)
                }
            } catch let error as NetworkError {
                self.showNetworkError(error)
            }
        }
    }
    
    /// Saves new user
    /// ```
    ///        viewModel.save()
    /// ```
    @MainActor
    func save() {
        validEmail = newUser.email.isValidEmail
        validName = !newUser.name.isEmpty
        validLocation = !newUser.location.isEmpty
        
        guard validEmail, validName, validLocation else { return }
        
        showLoading(true)
        let user = User(email: newUser.email, name: newUser.name, location: newUser.location, role: newUser.role)
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                try await self.usersUseCase.new(user)
                self.showLoading(false)
                self.newUser = UserData(email: "", name: "", location: "", role: .user)
                self.showCreatedUserAlert = true
            } catch let error as NetworkError {
                self.showNetworkError(error)
            }
        }
    }
    
    /// Resets all validation and users
    /// ```
    ///        viewModel.resetUsersValidation()
    /// ```
    func resetUsersValidation() {
        userFound = UserData(email: "", name: "", location: "", role: .user)
        newUser = UserData(email: "", name: "", location: "", role: .user)
        validEmail = true
        validName = true
        validLocation = true
        validEmailText = "valid_email_text"
        validNotEmptyText = "valid_empty_text"
        showCreatedUserAlert = false
        showModifiedUserAlert = false
    }
}

private extension UsersViewModel {
    @MainActor
    func getUserData(with email: String) {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.showLoading(true)
                let userFound = try await self.usersUseCase.find(by: email)
                
                self.userFound = UserData(
                    email: userFound.email,
                    name: userFound.name ?? "",
                    location: userFound.location ?? "",
                    role: userFound.role ?? .user
                )
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
            }
        }
    }
    
    func cleanUserFound() {
        userFound = UserData(email: "", name: "", location: "", role: .user)
    }
}
