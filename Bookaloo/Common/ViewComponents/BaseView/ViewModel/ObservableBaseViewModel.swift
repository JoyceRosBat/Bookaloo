//
//  ObservableBaseViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import Foundation

protocol ViewModelProtocol {
    func onAppear()
    func showNetworkError(_ error: NetworkError)
    func showError(with title: String, message: String)
    func showLoading(_ show: Bool)
    func showError(_ show: Bool)
}

class ObservableBaseViewModel: ViewModelProtocol, ObservableObject {
    /// show Loading animation
    /// ```
    ///        viewModel.showLoading = true
    /// ```
    @Published var showLoading: Bool = false
    
    /// Alert title text
    /// ```
    ///        viewModel.alertTitle = "Alert title"
    /// ```
    @Published var alertTitle: String = ""
    
    /// Alert message text
    /// ```
    ///        viewModel.alertMessage = "Alert Message"
    /// ```
    @Published var alertMessage: String = ""
    
    /// Show error popup
    /// ```
    ///        viewModel.showError = true
    /// ```
    @Published var showError: Bool = false
    
    /// Own user data to modify
    /// ```
    ///        viewModel.myUserToModify
    /// ```
    @Published var myUserToModify: UserData = UserData(email: "", name: "", location: "", role: .user)
    
    /// UserData
    /// ```
    ///        viewModel.user
    /// ```
    var user: User? {
        Storage.shared.get(key: .user, type: User.self)
    }
    
    /// Checks if user is logged in
    /// ```
    ///        viewModel.loggedIn
    var loggedIn: Bool {
        user?.email != nil
    }
    
    /// Checks if user is admin
    /// ```
    ///        viewModel.isAdmin
    var isAdmin: Bool {
        user?.role == .admin
    }
    
    /// Function to execute when view appears
    /// ```
    ///        viewModel.onAppear()
    /// ```
    func onAppear() {
        myUserToModify = UserData(email: user?.email ?? "", name: user?.email ?? "", location: user?.location ?? "", role: user?.role ?? .user)
    }
    
    /// Show loading animation
    /// ```
    ///        viewModel.showLoading(true)
    /// ```
    /// - Parameters:
    ///   - show: Bool to indicate if shows loading animation or not
    func showLoading(_ show: Bool) {
        Task {
            await MainActor.run {
                showLoading = show
            }
        }
    }
    
    /// Show error popup
    /// ```
    ///        viewModel.showError(true)
    /// ```
    /// - Parameters:
    ///   - show: Bool to indicate if shows error popup or not
    func showError(_ show: Bool) {
        Task {
            await MainActor.run {
                showError = show
            }
        }
    }
    
    /// Show error popup with netwrk error
    /// ```
    ///        viewModel.showNetworkError(error)
    /// ```
    /// - Parameters:
    ///   - error: NetworkError to show
    func showNetworkError(_ error: NetworkError) {
        showLoading(false)
        Task {
            await MainActor.run {
                switch error {
                case .apiError(let aPIErrorResponse):
                    alertTitle = "error_title"
                    alertMessage = aPIErrorResponse.reason
                    showError = true
                default:
                    alertTitle = "error_popup_title"
                    alertMessage = "error_popup_message"
                    showError = true
                }
            }
        }
    }
    
    /// Show error popup with given title and message
    /// ```
    ///        viewModel.showError(with: "", message: "")
    /// ```
    /// - Parameters:
    ///   - title: Title of the error popup
    ///   - message: Message of the error popup
    func showError(with title: String, message: String) {
        Task {
            await MainActor.run {
                showLoading = false
                alertTitle = title
                alertMessage = message
                showError = true
            }
        }
    }
    
    /// Logout from the session
    /// ```
    ///        viewModel.logout()
    /// ```
    func doLogout() {
        showLoading(true)
        Task {
            await MainActor.run{
                Storage.shared.cleanAll()
                Cache.shared.clean()
            }
        }
        showLoading(false)
    }
}
