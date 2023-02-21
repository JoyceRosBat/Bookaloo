//
//  ShopRequest.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum ShopRequest {
    case new(Order)
    case check(String)
    case orders(String)
    case status(String)
    case modify(OrderModify)
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
        case .status(let orderId): return "/orderStatus/\(orderId)"
        case .modify: return "/orderStatus"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .new, .orders: return .post
        case .check, .status: return .get
        case .modify: return .put
        }
    }
    
    var params: Any? {
        switch self {
        case .new(let order): return try? order.toDictionary()
        case .orders(let email): return ["email": email] as [String: String]
        case .modify(let order): return try? order.toDictionary()
        default: return nil
        }
    }
    
    var serviceName: String? {
        switch self {
        case .new: return "order_new"
        case .check: return "order_check"
        case .orders: return "orders_user"
        case .status: return "order_status"
        case .modify: return "order_modify"
        }
    }
}
