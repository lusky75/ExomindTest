//
//  HomeViewModel.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    var title: String {
        "home_title".localize()
    }
    
    var buttonTitle: String {
        "load_weather".localize()
    }
    
    init() {
    }
}
