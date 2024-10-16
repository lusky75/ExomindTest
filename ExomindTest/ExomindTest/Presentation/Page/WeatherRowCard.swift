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
    
    // Description to display according the statusCode
    var description: String? {
        weather.cod != 200 ? "Erreur \(weather.cod)" : weather.weather.first?.description
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.gray.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    // Name of the city
                    Text(weather.name)
                        .foregroundColor(foregroundColor)
                        .font(Font.custom(.helveticaNeue65, size: 20))
                    
                    Spacer()
                    
                    // Temperature in °C
                    Text(weather.temparatureText)
                        .foregroundColor(foregroundColor)
                        .font(Font.custom(.helveticaNeue65, size: 20))
                        .padding(.trailing, 10)
                    
                    // The icon URL
                    if let iconURL = weather.iconURL {
                        AsyncImageView(imageURL: iconURL)
                    } else {
                        Image("no_icon")
                    }
                }
                
                if let description = description {
                    Text(description)
                        .foregroundColor(foregroundColor)
                        .font(Font.custom(.helveticaNeue55, size: 18))
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
