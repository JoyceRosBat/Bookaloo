//
//  ShopRepository.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

final class ShopRepository: ShopRepositoryProtocol {
    let networkRequester: NetworkRequesterProtocol
    
    init(dependencies: NetworkDependenciesResolver) {
        self.networkRequester = dependencies.resolve()
    }
    
    func new(_ order: Order) async throws -> Order {
        let request = ShopRequest.new(order)
        return try await networkRequester.doRequest(request: request)
    }
    
    func checkOrder(by number: String) async throws -> Order {
        let request = ShopRequest.check(number)
        return try await networkRequester.doRequest(request: request)
    }
    
    func getOrders(of email: String) async throws -> [Order] {
        let request = ShopRequest.orders(email)
        return try await networkRequester.doRequest(request: request)
    }
    
    
}
