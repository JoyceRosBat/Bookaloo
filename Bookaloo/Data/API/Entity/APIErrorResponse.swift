//
//  APIErrorResponse.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 31/1/23.
//

import Foundation

struct APIErrorResponse: Codable {
    let error: Bool
    let reason: String
}
