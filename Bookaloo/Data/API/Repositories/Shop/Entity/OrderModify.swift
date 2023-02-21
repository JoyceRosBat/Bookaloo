//
//  OrderModify.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 7/2/23.
//

import Foundation

public struct OrderModify: Codable {
    let id: String
    let status: Status
    let admin: String
    
    enum CodingKeys: String, CodingKey {
        case id, admin
        case status = "estado"
    }
}
