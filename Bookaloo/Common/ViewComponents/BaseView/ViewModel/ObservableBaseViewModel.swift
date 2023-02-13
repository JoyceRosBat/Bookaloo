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
    @Published var showLoading: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showError: Bool = false
    var user: User? {
        Storage.shared.get(key: .user, type: User.self)
    }
    var loggedIn: Bool {
        user?.email != nil
    }
    var isAdmin: Bool {
        user?.role == .admin
    }
    
    func onAppear() {}
    
    func showLoading(_ show: Bool) {
        Task {
            await MainActor.run {
                showLoading = show
            }
        }
    }
    
    func showError(_ show: Bool) {
        Task {
            await MainActor.run {
                showError = show
            }
        }
    }
    
    func showNetworkError(_ error: NetworkError) {
        showLoading(false)
        Task {
            await MainActor.run {
                switch error {
                case .apiError(let aPIErrorResponse):
                    alertTitle = "Oops... Something went wrong"
                    alertMessage = aPIErrorResponse.reason
                    showError = true
                default:
                    alertTitle = "Oops... Something went wrong"
                    alertMessage = "Try again later..."
                    showError = true
                }
            }
        }
    }
    
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
    
    func doLogout() {
        showLoading(true)
        Storage.shared.cleanAll()
        Cache.shared.clean()
        showLoading(false)
    }
}
