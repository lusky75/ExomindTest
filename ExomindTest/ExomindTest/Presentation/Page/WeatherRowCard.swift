//
//  WeatherRowCard.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

struct WeatherRowCard: View {
    let weather: WeatherResponse
    
    private var foregroundColor: Color {
        weather.cod != 200 ? .red : .black
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.gray.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            HStack(alignment: .top, spacing: 0) {
                // Name of the city
                Text(weather.name)
                    .foregroundColor(foregroundColor)
                
                Spacer()
                
                // Temperature in °C
                Text(weather.temparatureText)
                    .foregroundColor(foregroundColor)
                
                // The icon URL
                if let iconURL = weather.iconURL {
                    AsyncImageView(imageURL: iconURL)
                } else {
                    Image("no_icon")
                }
            }
            .padding(.weatherRowCardPadding)
        }
        .frame(width: .screenWidthLessPadding, height: .weatherRowCardHeight)
        .cornerRadius(.weatherRowCardRadius)
    }
}

#Preview {
    WeatherRowCard(weather: WeatherResponse.notFoundWeather())
}
