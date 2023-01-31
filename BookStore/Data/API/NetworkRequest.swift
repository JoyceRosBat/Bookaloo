//
//  NetworkRequest.swift
//  SurpriseBag
//
//  Created by Joyce Rosario Batista on 14/01/23.
//

import Foundation

struct NetworkRequest {
    var request: URLRequest
    
    init(apiRequest: APIRequest) {
        var urlComponents = URLComponents(string: apiRequest.url?.description ?? Constants.urlBase)
        let subpath = urlComponents?.path.appending(apiRequest.subPath) ?? ""
        let path = subpath.appending(apiRequest.path)
        
        urlComponents?.path = path
        
        if let queryItems = apiRequest.queryItems {
            urlComponents?.queryItems = queryItems
        }
        
        guard let fullURL = urlComponents?.url else {
            assertionFailure("Couldn't build URL.")
            request = URLRequest(url: URL(string: "")!)
            return
        }
        
        request = URLRequest(url: fullURL)
        request.httpMethod = apiRequest.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = apiRequest.timeoutInterval
        
        if let params = apiRequest.params,
           apiRequest.method == .post || apiRequest.method == .put || apiRequest.method == .patch {
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
    }
}
