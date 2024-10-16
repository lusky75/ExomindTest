//
//  CGFloat+Extension.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import UIKit

extension CGFloat {
    static let horizontalPadding: Self = 30
    static let verticalSpacing: Self = 20
    static let screenWidthLessPadding: Self = UIScreen.screenWidth - 2 * horizontalPadding
    static let buttonHeight: Self = 50
    static let buttonRadius: Self = buttonHeight / 2
    
    /**
     HomeView screen
     */
    static let homeTitlePaddingTop: Self = 30
    
    /**
     WeatherView screen
     */
    static let weatherViewProgressHeight: Self = 30
    
    /**
     WeatherRowCard
     */
    static let weatherRowCardPadding: Self = 20
    static let weatherRowCardHeight: Self = 100
    static let weatherRowCardRadius: Self = 15
    
    /**
     ProgressBarView
     */
    static let progressBarTextPadding: Self = 20
}
