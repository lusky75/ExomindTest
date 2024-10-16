//
//  HomeView.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: .verticalSpacing) {
                titleView
                
                buttonView
            }
            .padding(.horizontalPadding)
            .frame(width: UIScreen.screenWidth, alignment: .leading)
        }
    }
    
    private var titleView: some View {
        Text(viewModel.title)
            .foregroundColor(.black)
            .font(Font.custom(.helveticaNeue75, size: 22))
            .padding(.top, .homeTitlePaddingTop)
    }
    
    private var buttonView: some View {
        NavigationLink {
            WeatherView(viewModel: WeatherViewModel())
        } label: {
            ZStack {
                // Rectangle as the background
                Rectangle()
                    .fill(Color.green)
                    .frame(width: .screenWidthLessPadding, height: .buttonHeight)
                    .cornerRadius(.buttonRadius)
                
                Text(viewModel.buttonTitle)
                    .foregroundColor(.white)
                    .font(Font.custom(.helveticaNeue65, size: 20))
            }
            .frame(alignment: .center)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
