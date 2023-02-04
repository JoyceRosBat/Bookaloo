//
//  ObservableBaseViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import Foundation

protocol ViewModelProtocol {
    func showNetworkError(_ error: NetworkError)
    func showError(with title: String, message: String)
    func onAppear()
}

class ObservableBaseViewModel: ViewModelProtocol, ObservableObject {
    @Published var showLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var showError: Bool = false
    var user: User? {
        Storage.shared.get(key: .user, type: User.self)
    }
    var loggedIn: Bool {
        user?.token != nil
    }
    
    func onAppear() {}
    func showNetworkError(_ error: NetworkError) {
        showLoading = false
        Task {
            await MainActor.run {
                switch error {
                case .apiError(let aPIErrorResponse):
                    alertTitle = "Oops... Something went wrong"
                    alertMessage = aPIErrorResponse.reason
                    showAlert = true
                default:
                    alertTitle = "Oops... Something went wrong"
                    alertMessage = "Try again later..."
                    showAlert = true
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
        showLoading = true
        Storage.shared.cleanAll()
        Cache.shared.clean()
        showLoading = false
    }
}
