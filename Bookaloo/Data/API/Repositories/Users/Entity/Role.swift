//
//  Role.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 4/2/23.
//

import Foundation

enum Role: String, Codable, CaseIterable, Identifiable {
    var id: Self { return self }
    case admin
    case user = "usuario"
}
