//
//  NetworkerError.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

/**
 Networker Error — enumerate list of errors from network.
 */
enum NetworkerError: Error {
    case invalidURL
    case serverError(NetworkerInfo)
    case generic(String)
    case genericError(NetworkerGenericError)
    case notFound
    case noNetwork
}

struct NetworkerInfo {
    let url: String
    let statusCode: Int
}

struct NetworkerGenericError {
    let cod: String
    let message: String
}

extension Error {
    var message: String {
        if let error = self as? NetworkerError {
            switch error {
            case .genericError(let genericError):
                return genericError.message
            case .generic(let message):
                return message
            default:
                return error.localizedDescription
            }
        }
        return self.localizedDescription
    }
}
