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
    
    // Boolean flag to indicate if list of weather are loaded
    @Published public var loaded: Bool = false
    
    // Progress of loading in percentage
    @Published public var progress: Double = 0.0
    
    @Published var weatherList: [WeatherResponse] = []
    
    private let homeService: HomeServiceProtocol
    
    
    private var currentMessageIndex: Int = 0
    private var currentCityIndex: Int = 0
    
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
     Message to display during the loading of weather data
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
    
    /**
     When the view appears, start the timers
     */
    public func onAppear() {
        startTimer()
    }
    
    public func restartTimer() {
        weatherList.removeAll()
        removeTimer()
        
        startTimer()
    }
    
    /**
     When the view disappears, it must remove the timers
     */
    public func onDisappear() {
        weatherList.removeAll()
        removeTimer()
        
    }
    
    private func startTimer() {
        loaded = false
        
        TimerQuery.shared.registerTimer(id: "updateMessage", interval: 1, repeats: true, block: displayMessage)
        
        TimerQuery.shared.registerTimer(id: "loadWeather", interval: 2, repeats: true, block: getWeather)
        
        displayMessage()
        getWeather()
    }
    
    private func removeTimer() {
        currentCityIndex = 0
        currentMessageIndex = 0
        progress = 0
        
        TimerQuery.shared.removeTimer(withId: "updateMessage")
        TimerQuery.shared.removeTimer(withId: "loadWeather")
        TimerQuery.shared.removeTimer(withId: "checkIfLoaded")
    }
    
    private func displayMessage() {
        currentMessageToDisplay = loadingMessages[currentMessageIndex]
        
        currentMessageIndex = (currentMessageIndex + 1) % loadingMessages.count
    }
    
    private func getWeather() {
        let cityName = cities[currentCityIndex]
        self.currentCityIndex += 1
        
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
                
                self.progress = Double(self.weatherList.count) / Double(self.cities.count)
                
                self.checkIfLoaded()
            })
            .store(in: &cancellables)
    }
    
    private func checkIfLoaded() {
        guard self.currentCityIndex < self.cities.count else {
            
            // Delay of 1 second before loading the list and remove timers
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loaded = true
                self.removeTimer()
            }
            return
        }
    }
}
