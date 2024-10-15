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
            VStack(alignment: .leading, spacing: 20) {
                titleView
                
                buttonView
            }
            .frame(width: UIScreen.screenWidth, alignment: .leading)
        }
    }
    
    private var titleView: some View {
        Text(viewModel.title)
            .foregroundColor(.black)
//            .font(Font.custom(.helveticaNeue75, size: 30))
            .padding(.top, .homeTitlePaddingTop)
            .padding(.leading, .homeTitlePaddingLeading)
    }
    
    private var buttonView: some View {
        NavigationLink {
            WeatherView(viewModel: WeatherViewModel())
        } label: {
            Text(viewModel.buttonTitle)
                .foregroundColor(.black)
                .padding(.top, .homeTitlePaddingTop)
                .padding(.leading, .homeTitlePaddingLeading)
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
