//
//  Report.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import Foundation

public struct Report: Codable {
    let email: String
    var ordered: [Int]? = nil
    var read: [Int]? = nil
    var books: [Int]? = nil
    
    enum CodingKeys: String, CodingKey {
        case email, ordered, books
        case read = "readed"
    }
}
