//
//  NetworkStatus.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

enum NetworkerStatus: Int {
    case OK = 200
    case CREATED = 201
    case INTERNAL_SERVER_ERROR = 500
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case CONFLICT = 409
    case SERVICE_UNAVAILABLE = 503
    case NOT_FOUND = 404
    case TIMEOUT = -1001
    case NETWORK_KO = -1009
}
