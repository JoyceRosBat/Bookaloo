//
//  UsersRequest.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum UsersRequest {
    case find(String)
    case new(User)
    case modify(User)
    case markRead(ReadBooks)
    case report(String)
    case read(String)
}

extension UsersRequest: APIRequest {
    var subPath: String {
        "/client"
    }
    
    var path: String {
        switch self {
        case .find: return "/query"
        case .markRead: return "/readQuery"
        case .report: return "/reportBooksUser"
        case .read: return "/readedBooks"
        default: return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .find, .new, .markRead, .report, .read: return .post
        case .modify: return .put
        } 
    }
    
    var params: Any? {
        switch self {
        case .read(let email): return ["email": email] as [String: String]
        case .report(let email): return ["email": email] as [String: String]
        case .find(let email): return ["email": email] as [String: String]
        case .new(let user): return try? user.toDictionary()
        case .modify(let user): return try? user.toDictionary()
        case .markRead(let readBooks): return try? readBooks.toDictionary()
        }
    }
    
    var serviceName: String? {
        switch self {
        case .find: return "user_find"
        case .new: return "user_new"
        case .modify: return "user_modify"
        case .markRead: return "user_mark_read"
        case .report: return "user_report"
        case .read: return "user_read"
        }
    }
}
