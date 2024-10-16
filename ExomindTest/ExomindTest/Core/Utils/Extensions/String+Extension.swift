//
//  String+Extension.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 16/10/2024.
//

import Foundation

// MARK: Fonts
extension String {
    /// Font names
    static let helveticaNeue35: Self = "HelveticaNeue-Thin"
    static let helveticaNeue45: Self = "HelveticaNeue-Light"
    static let helveticaNeue55: Self = "HelveticaNeue-Roman"
    static let helveticaNeue65: Self = "HelveticaNeue-Medium"
    static let helveticaNeue75: Self = "HelveticaNeue-Bold"
}

extension String {
    /**
     Extension function that encapsulates NSLocalizedString with the desired defaultLanguage to fall back on when the preferred language isn’t found.
     This will be used throughout the project.
     See "Localizable (en)".
     */
    func localize(comment: String = "") -> String {
        let defaultLanguage = "en"
        let value = NSLocalizedString(self, comment: comment)
        if value != self || NSLocale.preferredLanguages.first == defaultLanguage {
            return value // String localization was found
        }

        // Load resource for default language to be used as
        // the fallback language
        guard let path = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj"), let bundle = Bundle(path: path) else {
            return value
        }

        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
