//
//  Book.swift
//  BookStore
//
//  Created by Joyce Rosario Batista on 30/1/23.
//

import Foundation

import Foundation

// MARK: - Book
struct Book: Codable {
    let pages: Int?
    let year: Int
    let id: Int
    let rating: Double?
    let cover: String?
    let summary: String?
    let author: String
    let isbn: String?
    let title: String
    let plot: String?
}
