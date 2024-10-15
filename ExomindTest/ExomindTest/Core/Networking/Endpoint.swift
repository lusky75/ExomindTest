//
//  Endpoint.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

/**
 Endpoint — a handy struct that has path and queryItems properties.
 By defining extensions on it, we can conveniently create a base URL of our REST APIs, define specific endpoints and headers
 */

struct Endpoint {
    /**
     Define a path struct to match specific API requirements
    */
    var path: String?
    
    /**
     Define a path struct to match specific API version requirements
    */
    var version: String?
    
    /**
     Define query string parameters to match specific API requirements
    */
    var queryItems: [URLQueryItem]?
    
    /**
     Example header api
     */
    var headers: [String: Any] = [:]
    
    /**
     Example http body param
     */
    var parameters: [String: Any] = [:]
}

