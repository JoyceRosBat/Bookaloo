//
//  OrderStatus.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 7/2/23.
//

import Foundation

public struct OrderStatus: Codable {
    let status: Status
    
    enum CodingKeys: String, CodingKey {
        case status = "estado"
    }
}
