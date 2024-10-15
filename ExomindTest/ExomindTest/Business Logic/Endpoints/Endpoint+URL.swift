//
//  Endpoint+URL.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

/**
 Extension in which we construct the URL for API
 */

extension Endpoint {
    var baseApiUrl: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Bundle.baseApiURL
        components.path = (version ?? "") + (path ?? "")
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}
