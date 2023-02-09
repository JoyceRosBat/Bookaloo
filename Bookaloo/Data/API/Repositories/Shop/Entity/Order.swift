//
//  Order.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

struct Order: Codable, Identifiable {
    let email: String
    var status: Status? = nil
    var date: Date? = nil
    var order: [Int]? = nil
    var books: [Int]? = nil
    var id: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case email, books
        case status = "estado"
        case order = "pedido"
        case id = "npedido"
    }
    
    static let test: Order = .init(email: "email@email.com", status: .processing, date: .now, order: [1,4], books: [1,4,8], id: "Example-id-001")
}
