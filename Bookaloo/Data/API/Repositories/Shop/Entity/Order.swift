//
//  Order.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

public struct Order: Codable, Identifiable {
    public var id: String? = nil
    let email: String
    var status: Status? = nil
    var date: Date? = nil
    var order: [Int]? = nil
    var books: [Int]? = nil
    
    enum CodingKeys: String, CodingKey {
        case email, books, date
        case status = "estado"
        case order = "pedido"
        case id = "npedido"
    }
    
    static let test: Order = .init(id: "Example-id-001", email: "email@email.com", status: .processing, date: .now, order: [1,4], books: [1,4,8])
}
