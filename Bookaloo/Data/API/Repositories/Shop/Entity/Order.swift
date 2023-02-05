//
//  Order.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum Status: String, Codable {
    case received = "recibido"
    case sent = "enviado"
    case completed = "completado"
}

struct Order: Codable {
    let email: String
    var status: Status
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
}

struct OrderStatus: Codable {
    let status: Status
    
    enum CodingKeys: String, CodingKey {
        case status = "estado"
    }
}

struct OrderModify: Codable {
    let id: String
    let status: Status
    let admin: String
    
    enum CodingKeys: String, CodingKey {
        case id, admin
        case status = "estado"
    }
}
