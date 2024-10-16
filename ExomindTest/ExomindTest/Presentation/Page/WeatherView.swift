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
            VStack(alignment: .center, spacing: .verticalSpacing) {
                contentView
                
                if !viewModel.loaded {
                    progressBarView
                } else {
                    restartButton
                }
            }
            .padding(.horizontalPadding)
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
                .foregroundColor(.purple)
            //            .font(Font.custom(.helveticaNeue75, size: 30))
                .padding(.top, .homeTitlePaddingTop)
        }
    }
    
    @ViewBuilder
    private var listView: some View {
        LazyVStack(alignment: .leading, spacing: .verticalSpacing) {
            ForEach(viewModel.weatherList, id: \.id) { weather in
                WeatherRowCard(weather: weather)
            }
        }
    }
    
    @ViewBuilder
    private var progressBarView: some View {
        let progress = viewModel.progress
        ProgressBarView(value: progress, backgroundColor: .gray, foregroundColor: .purple, width: .screenWidthLessPadding, height: .weatherViewProgressHeight)
    }
    
    private var restartButton: some View {
        Button(action: restart, label: {
            ZStack {
                // Rectangle as the background
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: .screenWidthLessPadding, height: .buttonHeight)
                    .cornerRadius(.buttonRadius)
                
                Text(viewModel.restartButtonTitle)
                    .foregroundColor(.white)
            }
            .frame(alignment: .center)
        })
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
