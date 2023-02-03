//
//  Client.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

enum Role: String, Codable {
    case admin
    case user
}

struct Client: Codable {
    var name: String
    let email: String
    var location: String
    var role: Role
}
