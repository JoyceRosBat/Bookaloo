//
//  ViewModel.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

final class ViewModel: ObservableObject {
    var booksRepo = BooksRepository()
    var clientsRepo = ClientsRepository()
    var shopRepo = ShopRepository()
    
    init() {
        clients()
        books()
        shop()
    }
    
    func clients() {
        Task {
            let client = Client(name: "Joyce", email: "joyce@gmail.com", location: "Dubai")
            try await clientsRepo.new(client)
            var newClient = try await clientsRepo.findClient(by: client.email)
            print("Joyce: newClient", newClient)
            newClient.name = "Pepita"
            try await clientsRepo.modify(newClient)
            let modifyClient = try await clientsRepo.findClient(by: client.email)
            print("Joyce: modifyClient", modifyClient)
        }
    }
    
    func books() {
        Task {
            let books = try await booksRepo.getBooks()
            print("Joyce: books", books)
            let latest = try await booksRepo.getLatestBooks()
            print("Joyce: latest", latest)
            let find = try await booksRepo.findBook(startingWith: "the")
            print("Joyce: find", find)
            let authors = try await booksRepo.getAuthors()
            print("Joyce: authors", authors)
        }
    }
    
    func shop() {
        Task {
            let order = Order(email: "joyce@gmail.com", pedido: [4,288])
            let newOrder = try await shopRepo.new(order)
            print("Joyce: newOrder", newOrder)
            let checkOrder = try await shopRepo.checkOrder(by: "52CBFFFC-A5B7-4A72-9DED-87BC58DBD1FD")
            print("Joyce: checkOrder", checkOrder)
            let joyceOrders = try await shopRepo.getOrders(of: "joyce@gmail.com")
            print("Joyce: joyceOrders", joyceOrders)
        }
    }
    
}
