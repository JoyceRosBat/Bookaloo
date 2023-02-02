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
    
    func showError(_ error: NetworkError) async
    func onAppear()
}

class ObservableBaseViewModel: ViewModelProtocol, ObservableObject {
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    func onAppear() {}
    func showError(_ error: NetworkError) async {
        await MainActor.run {
            switch error {
            case .apiError(let aPIErrorResponse):
                alertTitle = "Oops... Algo ha salido mal"
                alertMessage = aPIErrorResponse.reason
                showAlert = true
                print("")
            default:
                alertTitle = "Oops... Algo ha salido mal"
                alertMessage = "Inténtelo de nuevo más tarde"
                showAlert = true
                print("")
            }
        }
    }
}
