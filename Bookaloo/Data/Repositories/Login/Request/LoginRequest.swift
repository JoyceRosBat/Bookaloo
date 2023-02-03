//
//  LoginRequest.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

enum LoginRequest {
    case validate(User)
}

extension LoginRequest: APIRequest {
    var subPath: String {
        "/login"
    }
    
    var path: String {
        switch self {
        case .validate: return "/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .validate: return .post
        }
    }
    
    var params: Any? {
        switch self {
        case .validate(let user): return try? user.toDictionary()
        }
    }
}
