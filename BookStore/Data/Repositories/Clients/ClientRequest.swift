//
//  ClientRequest.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum ClientRequest {
    case find(String)
    case new(Client)
    case modify(Client)
}

extension ClientRequest: APIRequest {
    var subPath: String {
        "/client"
    }
    
    var path: String {
        switch self {
        case .find: return "/query"
        default: return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .find, .new: return .post
        case .modify: return .put
        } 
    }
    
    var params: Any? {
        switch self {
        case .find(let email): return ["email": email] as [String: String]
        case .new(let client): return try? client.toDictionary()
        case .modify(let client): return try? client.toDictionary()
            
        }
    }
}
