//
//  ContentView.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                HomeView(viewModel: HomeViewModel())
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
