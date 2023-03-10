//
//  ShopViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 1/2/23.
//

import Foundation

public final class ShopViewModel: ObservableBaseViewModel {
    let dependencies: ShopDependenciesResolver
    var shopUseCase: ShopUseCaseProtocol {
        dependencies.resolve()
    }
    
    @Published var shopBook: Bool = false
    
    @Published var booksToShop: [Int: Int] = Storage.shared.get(key: .cart, type: [Int: Int].self) ?? [:]
    @Published var booksOrdered: Int = 0
    @Published var bookSelected: Book?
    
    @Published var showRemoveBookAlert: Bool = false
    @Published var finishShopAlert: Bool = false
    @Published var shopCompleteAlert: Bool = false
    
    @Published var pendingOrder: Order?
    
    @Published var total: Double = 0
    
    var viewDidLoad: Bool = false
    
    public init(dependencies: ShopDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    func updateCart() {
        if !viewDidLoad {
            updateShop()
            viewDidLoad = true
        }
    }
    
    /// Adds a book to the cart prepared to shop
    /// ```
    ///        viewModel.addToCat(book)
    /// ```
    /// - Parameters:
    ///   - book: The book to add to cart
    func addToCart(_ book: Book) {
        updateBooksToShop(with: book.apiID)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }
            self.shopBook = false
        }
    }
    
    /// Removes a book from the cart
    /// ```
    ///        viewModel.removeFromCart(book)
    /// ```
    /// - Parameters:
    ///   - book: The book to remove from the cart
    func removeFromCart(_ book: Book) {
        updateBooksToShop(with: book.apiID, shopCase: .decrement)
    }
    
    /// Removes the book selected
    /// ```
    ///        viewModel.removeBookSelected()
    /// ```
    func removeBookSelected() {
        if let bookSelected {
            booksToShop.removeValue(forKey: bookSelected.apiID)
            updateShop()
            Storage.shared.save(booksToShop, key: .cart)
            self.bookSelected = nil
        }
    }
    
    /// Creates the order and shop
    /// ```
    ///        viewModel.finishShop()
    /// ```
    @MainActor
    func finishShop() {
        showLoading(true)
        guard let email = user?.email else {
            showLoading(false)
            return
        }
        var order = Order(email: email)
        order.order = []
        booksToShop.forEach { (book, quantity) in
            for _ in 0..<quantity {
                order.order?.append(book)
            }
        }
        Task { [weak self] in
            guard let self = self else { return }
            do {
                self.pendingOrder = try await self.shopUseCase.new(order)
                self.booksToShop.removeAll()
                self.booksOrdered = 0
                Storage.shared.save(self.booksToShop, key: .cart)
                self.showLoading(false)
                self.shopCompleteAlert = true
            } catch let error as NetworkError {
                self.showNetworkError(error)
            }
        }
    }
}

private extension ShopViewModel {
    func updateShop() {
        booksOrdered = booksToShop.values.reduce(0, +)
    }
    
    func updateBooksToShop(with id: Int, shopCase: ShopBookCase = .increment) {
        if booksToShop.contains(where: { $0.key == id }) {
            var quantity = booksToShop.first(where: { $0.key == id })?.value ?? 0
            switch shopCase {
            case .increment:
                quantity += 1
            case .decrement:
                quantity -= 1
            }
            if quantity == 0 {
                booksToShop.removeValue(forKey: id)
            } else {
                booksToShop.updateValue(quantity, forKey: id)
            }
        } else {
            booksToShop[id] = 1
        }
        updateShop()
        Storage.shared.save(booksToShop, key: .cart)
    }
}

