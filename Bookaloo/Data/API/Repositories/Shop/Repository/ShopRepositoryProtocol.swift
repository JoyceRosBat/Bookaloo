//
//  ShopRepositoryProtocol.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

protocol ShopRepositoryProtocol {
    func new(_ order: Order) async throws -> Order
    func checkOrder(by number: String) async throws -> Order
    func getOrders(of email: String) async throws -> [Order]
    func getStatus(of orderId: String) async throws -> OrderStatus
    func modify(_ data: OrderModify) async throws -> EmptyResponse
}
