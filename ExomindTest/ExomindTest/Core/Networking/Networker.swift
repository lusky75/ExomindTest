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
    private func getResponse(data: Data, response: URLResponse) throws -> Data {
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
            .eraseToAnyPublisher()
    }
}
