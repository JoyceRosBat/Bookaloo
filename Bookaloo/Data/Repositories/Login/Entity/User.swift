//
//  User.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 3/2/23.
//

import Foundation

struct User: Codable {
    let email: String
    var password: String? = nil
    var token: String? = nil
}
