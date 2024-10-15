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
            VStack(alignment: .center, spacing: 20) {
                contentView
                
                progressView
            }
            .padding(.leading, .homeTitlePaddingLeading)
            .frame(width: UIScreen.screenWidth, alignment: .leading)
        }
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDisappear)
    }
    
    @ViewBuilder
    private var contentView: some View {
        // If the list is not loaded then display a message during the loading
        if !viewModel.loaded {
            messageView
        } else {
            listView
        }
    }
    
    @ViewBuilder
    private var messageView: some View {
        if let currentMessageToDisplay = viewModel.currentMessageToDisplay {
            Text(currentMessageToDisplay)
                .foregroundColor(.black)
            //            .font(Font.custom(.helveticaNeue75, size: 30))
                .padding(.top, .homeTitlePaddingTop)
        }
    }
    
    @ViewBuilder
    private var listView: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(viewModel.weatherList, id: \.id) { weather in
                WeatherRowCard(weather: weather)
            }
        }
    }
    
    @ViewBuilder
    private var progressView: some View {
        if !viewModel.loaded {
            let progress = viewModel.progress
            ProgressBarView(value: progress, backgroundColor: .gray, foregroundColor: .purple, width: UIScreen.screenWidth * 0.8, height: 30)
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
