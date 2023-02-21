//
//  NetworkRequester.swift
//  SurpriseBag
//
//  Created by Joyce Rosario Batista on 14/01/23.
//

import Foundation

public protocol NetworkRequesterProtocol {
    func doRequest<T: Decodable>(request: APIRequest) async throws -> T
}

public final class NetworkRequester: NetworkRequesterProtocol {
    public func doRequest<T: Decodable>(request: APIRequest) async throws -> T {
        try await handleRerequest(request: request)
    }
}

private extension NetworkRequester {
    func handleRerequest<T: Decodable>(request: APIRequest) async throws -> T {
        do {
            let networkRequest = NetworkRequest(apiRequest: request)
            let (data, response) = try await URLSession.shared.data(for: networkRequest.request)
            
            guard let response = response as? HTTPURLResponse else { throw NetworkError.httpError }
            switch response.statusCode {
            case 400...530:
                if let apiError = try? mapResponse(data: data, dataType: APIErrorResponse.self) {
                    throw NetworkError.apiError(apiError)
                } else {
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
    
    func mapResponse<T: Decodable>(data: Data, dataType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.jsonFormatter)
        return try decoder.decode(T.self, from: data)
    }
}
