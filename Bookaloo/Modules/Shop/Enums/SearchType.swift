//
//  SearchType.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 14/2/23.
//

import Foundation

enum SearchType: String, CaseIterable, Identifiable {
    var id: Self { return self }
    case email = "Email"
    case id = "Order id"
}
