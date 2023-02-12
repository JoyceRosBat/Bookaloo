//
//  Report.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 5/2/23.
//

import Foundation

struct Report: Codable {
    let email: String
    var ordered: [Int]? = nil
    var readed: [Int]? = nil
    var books: [Int]? = nil
}
