//
//  Cache.swift
//  Bookaloo
//
//  Created by Joyce Rosario Batista on 2/2/23.
//

import Foundation

class Cache {
    static let shared = Cache()
    private init() {}
    
    var books: [Book]? = nil
    
    func clean() {
        books = nil
    }
}
