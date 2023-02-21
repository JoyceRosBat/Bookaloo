//
//  MockError.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import Foundation

protocol NetworkErrorWithCode: Error {
    var code: Int { get }
    var errorCode: String { get }
}

struct MockError: NetworkErrorWithCode {
    var code: Int
    var errorCode: String
}
