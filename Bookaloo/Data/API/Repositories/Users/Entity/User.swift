//
//  User.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

struct User: Codable {
    let email: String
    var name: String? = nil
    var location: String? = nil
    var password: String? = nil
    var role: Role? = nil
    var token: String? = nil
}
