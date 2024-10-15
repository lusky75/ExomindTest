//
//  WeatherView.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 20) {
                titleView
                
                if !viewModel.loaded {
                    messageView
                } else {
                    contentView
                }
                
                progressView
            }
            .frame(width: UIScreen.screenWidth, alignment: .leading)
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    private var titleView: some View {
        Text(viewModel.title)
            .foregroundColor(.black)
//            .font(Font.custom(.helveticaNeue75, size: 30))
            .padding(.top, .homeTitlePaddingTop)
            .padding(.leading, .homeTitlePaddingLeading)
    }
    
    @ViewBuilder
    private var messageView: some View {
        if let currentMessageToDisplay = viewModel.currentMessageToDisplay {
            Text(currentMessageToDisplay)
                .foregroundColor(.black)
            //            .font(Font.custom(.helveticaNeue75, size: 30))
                .padding(.top, .homeTitlePaddingTop)
                .padding(.leading, .homeTitlePaddingLeading)
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(viewModel.weatherList, id: \.id) { weather in
                HStack {
                    // Name of the city
                    Text(weather.name)
                    
                    // Temperature in °C
                    Text(weather.temparatureText)
                    
                    // Icon URL
                    if let iconURL = weather.iconURL {
                        AsyncImage(url: iconURL)
                    }
                }
            }
        }
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private var progressView: some View {
        if !viewModel.loaded {
            Text("Progress")
        } else {
            Button(action: restart, label: {
                Text("Recommencer")
            })
        }
    }
}

extension WeatherView {
    private func onAppear() {
        viewModel.onAppear()
    }
    
    private func restart() {
        viewModel.restartTimer()
    }
    
    private func onDisappear() {
        viewModel.onDisappear()
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel())
}
