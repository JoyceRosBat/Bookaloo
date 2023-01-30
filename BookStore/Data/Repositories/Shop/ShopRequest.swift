//
//  ShopRequest.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum ShopRequest {
    case new(Order)
    case check(String)
    case orders(String)
}

extension ShopRequest: APIRequest {
    var subPath: String {
        "/shop"
    }
    
    var path: String {
        switch self {
        case .new: return "/newOrder"
        case .check(let number): return "/order/\(number)"
        case .orders: return "/orders"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .new, .orders: return .post
        case .check: return .get
        }
    }
    
    var params: Any? {
        switch self {
        case .new(let order): return try? order.toDictionary()
        case .orders(let email): return ["email": email] as [String: String]
        default: return nil
        }
    }
}
