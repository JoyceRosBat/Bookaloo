//
//  Order.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

struct Order: Codable {
    let email: String
    var pedido: [Int]? = nil
    var books: [Int]? = nil
    var npedido: String? = nil
}
