//
//  WeatherConfigurator.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

final class WeatherConfigurator {
    public static func configureWeatherView() -> WeatherView {
        let weatherView = WeatherView(viewModel: WeatherViewModel())
        return weatherView
    }
}
