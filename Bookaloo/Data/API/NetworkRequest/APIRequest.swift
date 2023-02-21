//
//  APIRequest.swift
//  SurpriseBag
//
//  Created by Joyce Rosario Batista on 14/01/23.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public protocol APIRequest {
    var serviceName: String? { get }
    var url: String? { get }
    var subPath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var params: Any? { get }
    var timeoutInterval: TimeInterval { get }
}

extension APIRequest {
    var serviceName: String? { nil }
    var url: String? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var params: Any? { nil }
    var timeoutInterval: TimeInterval { 10.0 }
}
