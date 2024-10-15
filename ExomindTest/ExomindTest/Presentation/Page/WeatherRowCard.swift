//
//  WeatherRowCard.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

struct WeatherRowCard: View {
    let weather: WeatherResponse
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.gray.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            HStack(alignment: .top, spacing: 0) {
                // Name of the city
                Text(weather.name)
                
                Spacer()
                
                // Temperature in °C
                Text(weather.temparatureText)
                
                // The icon URL
                if let iconURL = weather.iconURL {
                    AsyncImage(url: iconURL)
                }
            }
            .padding(10)
        }
        .frame(width: UIScreen.screenWidth * 0.9, height: 100)
        .cornerRadius(15)
    }
}
//
//#Preview {
//    WeatherRowCard(weather: WeatherResponse)
//}
