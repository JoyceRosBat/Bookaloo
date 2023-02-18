//
//  UserData.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 16/2/23.
//

import Foundation

struct UserData {
    var email: String
    var name: String
    var location: String
    var role: Role
    
    static let test: UserData = .init(email: "joyce@email.com", name: "Joyce Rosario Batista", location: "Tacoronte", role: .admin)
}
