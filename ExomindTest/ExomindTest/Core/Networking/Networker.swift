//
//  Networker.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation
import Combine

typealias Headers = [String: Any]

protocol NetworkerProtocol: AnyObject {
    func get<T>(url: URL,
                headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
}

final class Networker: NetworkerProtocol {
//    private func debugData(data: Data) {
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//            Log.error(json)
//        } catch {
//            Log.error("debugData error: \(error)")
//        }
//    }
    
    private func getResponse(data: Data, response: URLResponse) throws -> Data {
        // When the API returns an invalid status code (not between 200 and 299), send a NetworkError to handle the errors
        guard let httpResponse = response as? HTTPURLResponse,
            200..<300 ~= httpResponse.statusCode else {
            throw NetworkerError.serverError(NetworkerInfo(url: (response as? HTTPURLResponse)?.url?.absoluteString ?? "",
                                                           statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0))
        }
        
        return data
    }
    /**
     returns a publisher containing a model
     */
    func get<T>(url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { key, value in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
//                self.debugData(data: data)
                return try self.getResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                if let urlError = error as? URLError {
                    switch urlError.code {
                    case .cannotFindHost:
                        return NetworkerError.serverError(NetworkerInfo(url: "The server with the specified hostname could not be found.", statusCode: URLError.cannotFindHost.rawValue))
                    case .notConnectedToInternet:
                        return URLError(.notConnectedToInternet, userInfo: ["description": "Please check your internet connection."])
                    default:
                        return urlError // Keep the original error for other cases
                    }
                }
                return error // Any other error (decoding, etc.)
            }
            .eraseToAnyPublisher()
    }
}
