//
//  BooksRequest.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum BooksRequest {
    case list
    case latest
    case find(String)
    case authors
    case author(String)
}

extension BooksRequest: APIRequest {
    var subPath: String {
        "/books"
    }
    
    var path: String {
        switch self {
        case .list: return "/list"
        case .latest: return "/latest"
        case .find(let text): return "/find/\(text)"
        case .authors: return "/authors"
        case .author(let id): return "/getAuthor/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var serviceName: String? {
        switch self {
        case .list: return "books_list"
        case .latest: return "books_latest"
        case .find: return "books_find"
        case .authors: return "books_authors"
        case .author: return "books_author_id"
        }
    }
}
