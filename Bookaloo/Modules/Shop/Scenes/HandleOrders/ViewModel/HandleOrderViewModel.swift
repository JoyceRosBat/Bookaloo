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
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.searchOrders = try await self.shopUseCase.getAll(email)
                self.ordersEmpty = self.searchOrders.isEmpty
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
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
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.searchOrders = try await self.shopUseCase.orders(of: email)
                self.ordersEmpty = self.searchOrders.isEmpty
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
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
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let order = try await shopUseCase.check(by: id)
                self.searchOrders = [order]
                self.ordersEmpty = searchOrders.isEmpty
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
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
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let orderToModify = OrderModify(
                    id: orderId,
                    status: status,
                    admin: user?.email ?? ""
                )
                try await self.shopUseCase.modify(orderToModify)
                if let index = self.searchOrders.firstIndex(where: { $0.id == orderId }) {
                    self.searchOrders[index].status = status
                }
                self.showLoading(false)
            } catch let error as NetworkError {
                self.showNetworkError(error)
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
