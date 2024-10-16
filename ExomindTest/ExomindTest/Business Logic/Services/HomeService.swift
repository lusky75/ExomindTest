//
//  HomeService.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation
import Combine

protocol HomeServiceProtocol: AnyObject {
    func getWeather(city: String) -> AnyPublisher<WeatherResponse, Error>
}

final class HomeService: HomeServiceProtocol {
    private let networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getWeather(city: String) -> AnyPublisher<WeatherResponse, Error> {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: city + ",FR"),
            URLQueryItem(name: "units", value: "metric"), // to convert the temperature to degree celcius
            URLQueryItem(name: "appid", value: Bundle.apiKey),
        ]
        let endpoint = Endpoint.getWeather(queryItems: queryItems)
        
        return networker.get(url: endpoint.baseApiUrl, headers: endpoint.headers)
    }
    
}
