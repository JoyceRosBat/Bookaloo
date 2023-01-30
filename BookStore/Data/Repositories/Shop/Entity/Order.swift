//
//  Order.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

struct Order: Codable {
    let email: String
    let books: [Int]
    let npedido: String
}
