//
//  HandleOrderViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 19/2/23.
//

import Foundation

public final class HandleOrderViewModel: ObservableBaseViewModel {
    let dependencies: ShopDependenciesResolver
    var shopUseCase: ShopUseCaseProtocol {
        dependencies.resolve()
    }
    
    @Published var ordersEmpty: Bool = false
    @Published var searchOrders: [Order] = []
    
    public init(dependencies: ShopDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    /// Get all orders
    /// ```
    ///        viewModel.getAll()
    /// ```
    @MainActor
    func getAll() {
        guard let email = user?.email else { return }
        cleanSearchOrders()
        showLoading(true)
        Task {
            do {
                let list = try await shopUseCase.getAll(email)
                searchOrders = list
                ordersEmpty = searchOrders.isEmpty
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Get the orders of a user given the email
    /// ```
    ///        viewModel.getOrders(by: "email")
    /// ```
    /// - Parameters:
    ///  - email: The email of the user
    @MainActor
    func getOrders(by email: String) {
        cleanSearchOrders()
        showLoading(true)
        Task {
            do {
                let list = try await shopUseCase.orders(of: email)
                searchOrders = list
                ordersEmpty = searchOrders.isEmpty
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Get an order given its number
    /// ```
    ///        viewModel.getOrder(id: "order-id")
    /// ```
    /// - Parameters:
    ///  - id: the id number
    @MainActor
    func getOrder(by id: String) {
        cleanSearchOrders()
        showLoading(true)
        Task {
            do {
                let order = try await shopUseCase.check(by: id)
                searchOrders = [order]
                ordersEmpty = searchOrders.isEmpty
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Modify an order by its id
    /// ```
    ///        viewModel.modify("order-id")
    /// ```
    /// - Parameters:
    ///  - orderId: the id number
    @MainActor
    func modify(_ orderId: String?, status: Status) {
        guard let orderId else { return }
        showLoading(true)
        Task {
            do {
                let orderToModify = OrderModify(
                    id: orderId,
                    status: status,
                    admin: user?.email ?? ""
                )
                try await shopUseCase.modify(orderToModify)
                if let index = searchOrders.firstIndex(where: { $0.id == orderId }) {
                    searchOrders[index].status = status
                }
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    /// Cleans the list f orders search
    /// ```
    ///        viewModel.cleanSearchOrders()
    /// ```
    @MainActor
    func cleanSearchOrders() {
        searchOrders.removeAll()
    }
}
