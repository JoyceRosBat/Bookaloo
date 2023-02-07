//
//  BooksViewModel.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class BooksViewModel: ObservableBaseViewModel {
    @Published var searchText: String = ""
    var viewDidLoad = false
    let dependencies: BooksDependenciesResolver
    var booksUseCase: BooksUseCaseProtocol {
        dependencies.resolve()
    }
    var books = [Book]()
    var booksToShop: [Int: Int] = [:]
    var filteredBooks: [Book] {
        searchText.isEmpty ? books : books.filter { $0.title.lowercased().contains(searchText.lowercased()) }
    }
    var order: Order? = Storage.shared.get(key: .order, type: Order.self)
    
    init(dependencies: BooksDependenciesResolver) {
        self.dependencies = dependencies
    }
    
    // On appear, fetch list of books
    override func onAppear() {
        if !viewDidLoad {
            updateShop()
            viewDidLoad = true
        }
        showLoading(true)
        Task {
            do {
                books = try await booksUseCase.fetch()
                showLoading(false)
            } catch let error as NetworkError {
                showNetworkError(error)
            }
        }
    }
    
    func updateShop() {
        order?.order?.forEach { bookId in
            updateBooksToShop(with: bookId)
        }
    }
    
    func addToCart(_ book: Book) {
        if order == nil,
           let email = user?.email {
            order = Order(email: email)
            order?.order = []
        }
        order?.order?.append(book.id)
        Storage.shared.save(order, key: .order)
        updateBooksToShop(with: book.id)
    }
    
    func updateBooksToShop(with id: Int) {
        if booksToShop.contains(where: { $0.key == id }) {
            let quantity = booksToShop.first(where: { $0.key == id })?.value ?? 0
            booksToShop.updateValue(quantity + 1, forKey: id)
        } else {
            booksToShop[id] = 1
        }
    }
}
