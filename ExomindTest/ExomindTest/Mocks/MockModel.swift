//
//  MockModel.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 16/10/2024.
//

import Foundation

struct MockModel {
    
    static var notFoundWeather: WeatherResponse {
        let notFoundWeather: WeatherResponse = load("notFoundWeather.json")
        return notFoundWeather
    }
    
    /**
     Load local json and return a Codable model from the data
     */
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
