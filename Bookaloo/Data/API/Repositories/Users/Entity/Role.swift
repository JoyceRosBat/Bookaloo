//
//  Role.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 4/2/23.
//

import Foundation

public enum Role: String, Codable, CaseIterable, Identifiable {
    public var id: Self { return self }
    case admin
    case user = "usuario"
}
