//
//  Bundle+Extension.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

extension Bundle {
    class func infoForKey(_ key: String) -> String? {
        return (Bundle.main.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
    }
    
    static var baseURL: String {
        guard let baseURL = infoForKey("BASE_URL"), !baseURL.isEmpty else {
            fatalError("BASE_URL not found in plist")
        }
        return baseURL
    }
    
    static var baseApiURL: String {
        guard let baseApiURL = infoForKey("BASE_API_URL"), !baseApiURL.isEmpty else {
            fatalError("BASE_API_URL not found in plist")
        }
        return baseApiURL
    }
    
    static var apiKey: String {
        guard let apiKey = infoForKey("API_KEY"), !baseURL.isEmpty else {
            fatalError("API_KEY not found in plist")
        }
        return apiKey
    }
}
