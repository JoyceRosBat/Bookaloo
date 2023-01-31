//
//  Requester.swift
//  SurpriseBag
//
//  Created by Joyce Rosario Batista on 14/01/23.
//

import Foundation

final class Requester {
    func doRequest<T: Decodable>(request: APIRequest) async throws -> T {
        return try await handleRerequest(request: request)
    }
    
    func doRequest(request: APIRequest) async throws -> EmptyResponse {
        try await handleRerequest(request: request)
    }
    
}

extension Requester {
    struct EmptyResponse: Codable {}
    
    func handleRerequest<T: Decodable>(request: APIRequest) async throws -> T {
        do {
            let networkRequest = NetworkRequest(apiRequest: request)
            let (data, response) = try await URLSession.shared.data(for: networkRequest.request)
            
            guard let response = response as? HTTPURLResponse else { throw NetworkError.httpError }
            switch response.statusCode {
            case 400...530:
                do {
                    let apiError = try mapResponse(data: data, dataType: APIErrorResponse.self)
                    throw NetworkError.apiError(apiError)
                } catch {
                    throw NetworkError.status(response.statusCode)
                }
            default: ()
            }
            do {
                if data.isEmpty {
                    return EmptyResponse() as! T
                }
                let mappedResponse = try mapResponse(data: data, dataType: T.self)
                return mappedResponse
            } catch {
                throw NetworkError.parsing
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
    
    private func mapResponse<T: Decodable>(data: Data, dataType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
