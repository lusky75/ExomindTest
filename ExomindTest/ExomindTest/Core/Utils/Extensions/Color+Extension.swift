//
//  Color+Extension.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 15/10/2024.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    static let gray200 = UIColor.hexa(hex: "#DDDDDD")
    static let gray300 = UIColor.hexa(hex: "#CCCCCC")
    static let gray400 = UIColor.hexa(hex: "#999999")
    static let gray500 = UIColor.hexa(hex: "#7A7A7A")
    static let gray600 = UIColor.hexa(hex: "#666666")
    static let gray700 = UIColor.hexa(hex: "#595959")
    static let gray800 = UIColor.hexa(hex: "#333333")
    static let gray900 = UIColor.hexa(hex: "#121212")
    static let grayMedium = UIColor.hexa(hex: "#8F8F8F")
    static let white100 = UIColor.hexa(hex: "#FFFFFF")
    static let orange500 = UIColor.hexa(hex: "#FF7900")
}

extension Color {
    static let clearColor: Self = .clear

    /// Base/Color/Gray/200
    static let gray200Color: Self = Color.dynamic(light: .gray200,
                                                  dark: .gray200)

    /// Base/Color/Gray/300
    static let gray300Color: Self = Color.dynamic(light: .gray300,
                                                  dark: .gray300)
    
    /// Base/Color/Gray/400
    static let gray400Color: Self = Color.dynamic(light: .gray400,
                                                  dark: .gray400)
    
    /// Base/Color/Orange/500
    static let tintColor: Self = Color.dynamic(light: .orange500,
                                               dark: .orange500)
    
    /// Base/Color/Green/500
    static let green500Color: Self = Color.dynamic(light: UIColor.hexa(hex: "#50BE87"),
                                                   dark: UIColor.hexa(hex: "#50BE87"))
    
    /// Base/Color/Functional/Red
    static let errorColor: Self = Color.dynamic(light: UIColor.hexa(hex: "#CD3C14"),
                                                dark: UIColor.hexa(hex: "#CD3C14"))
    
    /// Base/Color/Gray/500
    static let gray500Color: Self = Color.dynamic(light: .gray500,
                                                  dark: .gray500)
    
    /// Base/Color/Gray/600
    static let gray600Color: Self = Color.dynamic(light: .gray600,
                                                  dark: .gray600)
    
    /// Base/Color/Gray/700
    static let gray700Color: Self = Color.dynamic(light: .gray700,
                                                  dark: .gray700)
    /// Base/Color/Gray/800
    static let gray800Color: Self = Color.dynamic(light: .gray800,
                                                  dark: .gray800)
    
    /// Base/Color/Gray/900
    static let gray900Color: Self = Color.dynamic(light: .gray900,
                                                  dark: .gray900)
    
    static let grayMedium: Self = Color.dynamic(light: .grayMedium,
                                                dark: .grayMedium)
    
    /// Base/Color/White/100
    static let whiteColor: Self = Color.dynamic(light: .white100,
                                                dark: .white100)
    
    /// Base/Color/Black
    static let blackColor: Self = Color.dynamic(light: UIColor.hexa(hex: "#000000"),
                                                dark: UIColor.hexa(hex: "#000000"))
    
    /// Base/Color/Gray/Darkd
    static let darkGrayColor: Self = Color.dynamic(light: UIColor.hexa(hex: "#202020"),
                                                   dark: UIColor.hexa(hex: "#202020"))

    /// Base/Color/Purple/500
    static let purple500color: Self = Color.dynamic(light: UIColor.hexa(hex: "#A885D8"),
                                                    dark: UIColor.hexa(hex: "#A885D8"))
    
    /// Finger print
    static let fingerprintTextcolor: Self = Color.dynamic(light: UIColor.hexa(hex: "#F0F0F0"),
                                                          dark: UIColor.hexa(hex: "#F0F0F0"))
    static let fingerprintBgcolor: Self = Color.dynamic(light: UIColor.hexa(hex: "#5F830B"),
                                                        dark: UIColor.hexa(hex: "#5F830B"))
}

/**
 Utility method
 */
extension UIColor {
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static func hexa(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 && (cString.count) != 8 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        // if there is 8 characters, the first 2 digits are the alpha
        let isAlpha = cString.count == 8 ? true : false
        
        return UIColor(
            red: CGFloat((rgbValue & (isAlpha ? 0x00FF0000 : 0xFF0000)) >> 16) / 255.0,
            green: CGFloat((rgbValue & (isAlpha ? 0x0000FF00 : 0x00FF00)) >> 8) / 255.0,
            blue: CGFloat(rgbValue & (isAlpha ? 0x000000FF : 0x0000FF)) / 255.0,
            alpha: (isAlpha ? CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0 : CGFloat(1.0))
        )
    }
}

extension Color {
    static func dynamic(light: UIColor, dark: UIColor) -> Color {
        return Color(UIColor.dynamic(light: light, dark: dark))
    }
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> Color {
        return Color(UIColor.rgba(red: red, green: green, blue: blue, alpha: alpha))
    }
    static func hexa(hex: String) -> Color {
        return Color(UIColor.hexa(hex: hex))
    }
}

/**
 Making Color Codable to parse hexadecimal color string
 */
extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        
        self = Color.hexa(hex: hex)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(toString())
    }
    
    /**
     Convert the Color in a string of this format: #AARRGGBB (white: #FFFFFFFF)
     It's use to encode the color in order to implement the Codable protocol
     */
    private func toString() -> String? {
        guard let components = cgColor?.components, components.count >= 3 else {
              return nil
        }
        
        let isAlpha = components.count >= 4 ? true : false
        
        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])
        let alpha = isAlpha ? Float(components[3]) : 1.0
        
        if isAlpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(alpha * 255), lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(red * 255), lroundf(green * 255), lroundf(blue * 255))
        }
    }
    
}

