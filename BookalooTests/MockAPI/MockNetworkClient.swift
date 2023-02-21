//
//  MockNetworkClient.swift
//  BookalooTests
//
//  Created by Joyce Rosario Batista on 21/2/23.
//

import Foundation
import Bookaloo

struct MockNetworkClient: NetworkRequesterProtocol {
    var shouldFail: Bool = false
    var failError: Int = 500
    
    func doRequest<T: Decodable>(request: APIRequest) throws -> T {
        guard !shouldFail else {
            throw MockError(code: failError, errorCode: "\(failError)")
        }
        guard let filePath = Bundle.main.url(forResource: request.serviceName, withExtension: "json") else {
            throw NetworkError.parsing
        }
        do {
            let data = try Data(contentsOf: filePath)
            if data.isEmpty {
                return EmptyResponse() as! T
            }
            return try mapResponse(data: data, dataType: T.self)
        } catch let error {
            throw NetworkError.general(error)
        }
    }
    
    func mapResponse<T: Decodable>(data: Data, dataType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.jsonFormatter)
        return try decoder.decode(T.self, from: data)
    }
}
