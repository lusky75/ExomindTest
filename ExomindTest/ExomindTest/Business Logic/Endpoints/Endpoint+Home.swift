//
//  Endpoint+Home.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

extension Endpoint {
    static func getWeather(queryItems: [URLQueryItem]) -> Self {
        return Endpoint(path: "/weather", version: "/data/2.5", queryItems: queryItems)
    }
}
