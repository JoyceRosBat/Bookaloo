//
//  ShopOrdersViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 19/2/23.
//

import Foundation

final class ShopOrdersViewModel: ObservableBaseViewModel {
    let dependencies: ShopDependenciesResolver
    var shopUseCase: ShopUseCaseProtocol {
        dependencies.resolve()
    }
    
    @Published var ordersStatus: [PurchaseStatus] = [.inProgress, .delivered, .cancelled]
    @Published var userOrders: [Order] = []
    @Published var deliveredList: [Order] = []
    @Published var inProgressList: [Order] = []
    @Published var cancelledList: [Order] = []
    
    init(dependencies: ShopDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    /// Get the orders of a user
    /// ```
    ///        viewModel.getOrders()
    /// ```
    @MainActor
    func getOrders() {
        showLoading(true)
        guard let email = user?.email else {
            showLoading(false)
            return
        }
        Task {
            do {
                self.userOrders = try await shopUseCase.orders(of: email)
                
                inProgressList = userOrders
                    .filter{ $0.status == .processing || $0.status == .sent || $0.status == .received }
                    .sorted(by: { $0.status?.rawValue ?? "" < $1.status?.rawValue ?? "" })
                    .sorted(by: { $0.date ?? .now < $1.date ?? .now })
                deliveredList = userOrders.filter{ $0.status == .delivered }
                    .sorted(by: { $0.date ?? .now < $1.date ?? .now })
                cancelledList = userOrders
                    .filter{ $0.status == .canceled || $0.status == .returned }
                    .sorted(by: { $0.status?.rawValue ?? "" < $1.status?.rawValue ?? "" })
                    .sorted(by: { $0.date ?? .now < $1.date ?? .now })
                
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
}
