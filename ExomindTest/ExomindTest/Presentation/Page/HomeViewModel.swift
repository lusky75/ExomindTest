//
//  HomeViewModel.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    var title: String {
        "Page d'accueil"
    }
    
    var buttonTitle: String {
        "Charger la météo des différentes villes"
    }
    
    init() {
    }
}
