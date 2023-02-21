//
//  User.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

public struct User: Codable {
    var email: String
    var name: String? = nil
    var location: String? = nil
    var password: String? = nil
    var role: Role? = nil
    var token: String? = nil
    
    static let test: User = .init(email: "joyce@email.com", name: "Joyce Rosario Batista", location: "Tacoronte")
}
