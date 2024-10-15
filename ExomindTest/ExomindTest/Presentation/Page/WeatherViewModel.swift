//
//  WeatherViewModel.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published public var currentMessageToDisplay: String?
    @Published public var loaded: Bool = false
    var weatherList: [WeatherResponse] = []
    
    private var currentMessageIndex = 0
    private var currentCityIndex = 0
    
    private let homeService: HomeServiceProtocol
    
    var title: String {
        "Chargement de la météo"
    }
    
    /**
     cities name to be used as parameter to get the weather from an API Service
     */
    private var cities: [String] = [
        "Rennes",
        "Paris",
        "Nantes",
        "Bordeaux",
        "Lyon"
    ]
    
    /**
     Message to display during the loading
     */
    private var loadingMessages: [String] = [
        "Nous téléchargeons les données…",
        "C’est presque fini…",
        "Plus que quelques secondes avant d’avoir le résultat…"
    ]
    
    /**
     We also add the cancellables property to store future subscriptions
    */
    private var cancellables = Set<AnyCancellable>()
    
    init(homeService: HomeServiceProtocol = HomeService()) {
        self.homeService = homeService
    }
    
    public func onAppear() {
        startTimer()
    }
    
    public func restartTimer() {
        removeTimer()
        startTimer()
        loaded = false
    }
    
    public func onDisappear() {
        removeTimer()
        loaded = false
    }
    
    private func startTimer() {
        weatherList = []
        displayMessage()
        
        TimerQuery.shared.registerTimer(id: "updateMessage", interval: 6, repeats: true, block: displayMessage)
        
        TimerQuery.shared.registerTimer(id: "loadWeather", interval: 1, repeats: true, block: loadWeather)
    }
    
    private func removeTimer() {
        currentCityIndex = 0
        currentMessageIndex = 0
        
        TimerQuery.shared.removeTimer(withId: "updateMessage")
        TimerQuery.shared.removeTimer(withId: "loadWeather")
    }
    
    private func displayMessage() {
        currentMessageToDisplay = loadingMessages[currentMessageIndex]
        
        currentMessageIndex = (currentMessageIndex + 1) % loadingMessages.count
    }
    
    private func loadWeather() {
        getWeather()
    }
    
    private func getWeather() {
        guard currentCityIndex < 5 else {
            loaded = true
            removeTimer()
            return
        }
        let cityName = cities[currentCityIndex]
        currentCityIndex += 1
        homeService.getWeather(city: cityName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    Log.error(error)
                case .finished: break
                }
            }, receiveValue: { response in
                self.weatherList.append(response)
                print("ROUGEE: \(response)")
            })
            .store(in: &cancellables)
    }
}
