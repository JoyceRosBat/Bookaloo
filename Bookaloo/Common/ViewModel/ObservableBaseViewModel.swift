//
//  ObservableBaseViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import Foundation

protocol ViewModelProtocol {
    var showAlert: Bool { get nonmutating set }
    var alertTitle: String { get nonmutating set  }
    var alertMessage: String { get nonmutating set  }
    
    func showNetworkError(_ error: NetworkError)
    func showError(with title: String, message: String)
    func onAppear()
}

class ObservableBaseViewModel: ViewModelProtocol, ObservableObject {
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    func onAppear() {}
    func showNetworkError(_ error: NetworkError) {
        Task {
            await MainActor.run {
                switch error {
                case .apiError(let aPIErrorResponse):
                    alertTitle = "Oops... Algo ha salido mal"
                    alertMessage = aPIErrorResponse.reason
                    showAlert = true
                default:
                    alertTitle = "Oops... Algo ha salido mal"
                    alertMessage = "Inténtelo de nuevo más tarde"
                    showAlert = true
                }
            }
        }
    }
    
    func showError(with title: String, message: String) {
        Task {
            await MainActor.run {
                alertTitle = title
                alertMessage = message
                showAlert = true
            }
        }
    }
}
