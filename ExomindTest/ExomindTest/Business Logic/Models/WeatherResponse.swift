//
//  WeatherResponse.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

struct WeatherResponse: Codable {
    struct Coordinate: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct WeatherInfo: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct WeatherMain: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int
        let humidity: Int
        let seaLevel: Int
        let grndLevel: Int
        
        enum CodingKeys: String, CodingKey, Codable {
            case temp
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case pressure
            case humidity
            case seaLevel = "sea_level"
            case grndLevel = "grnd_level"
        }
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct Cloud: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
    let coord: Coordinate
    let weather: [WeatherInfo]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let cloud: Cloud?
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

extension WeatherResponse {
    static func notFoundWeather() -> Self {
        return MockModel.notFoundWeather
    }
    
    var temparatureText: String {
        String(Int(main.temp)) + " °C"
    }
    
    // Get the icon from https://openweathermap.org/img/wn/{iconName}.png
    var iconURL: String? {
        guard let iconName = weather.first?.icon else {
            return nil
        }
        return "https://" + Bundle.baseURL + "/img/wn/" + iconName + ".png"
    }
}
