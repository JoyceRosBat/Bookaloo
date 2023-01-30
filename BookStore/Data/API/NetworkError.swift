//
//  NetworkError.swift
//  SurpriseBag
//
//  Created by Joyce Rosario Batista on 14/01/23.
//

import Foundation

enum NetworkError: Error {
    case general(Error)
    case status(Int)
    case parsing
    case dataError(Error)
    case httpError
    
    var description: String {
        switch self {
        case .general(let error): return "Error general: \(error)"
        case .status(let code): return "Error status code: \(code)"
        case .parsing: return "Error parsing data"
        case .dataError(let error): return "Data error: \(error)"
        case .httpError: return "Conection is not http"
        }
    }
}
