//
//  LanguageManager.swift
//  Discovery
//
//  Created by Discovery on 10/5/2023.
//

import Foundation

class LanguageManager :ObservableObject{
    static let shared = LanguageManager()
    private let userDefaults = UserDefaults.standard
    private let availableLanguages = ["en", "fr"]
    
    var currentLanguage: String {
        didSet {
            userDefaults.set([currentLanguage], forKey: "AppleLanguages")
            userDefaults.synchronize()
        }
    }
    
    private init() {
        if let currentLanguage = userDefaults.object(forKey: "AppleLanguages") as? [String],
           let language = currentLanguage.first,
           availableLanguages.contains(language) {
            self.currentLanguage = language
        } else {
            self.currentLanguage = "en"
        }
    }
    
    func setLanguage(_ language: String) {
        guard availableLanguages.contains(language) else {
            return
        }
        currentLanguage = language
        userDefaults.set([currentLanguage], forKey: "AppleLanguages")
        userDefaults.synchronize() // add this line
    }
}
