//
//  LanguageSelectionView.swift
//  Discovery
//
//  Created by Discovery on 10/5/2023.
//

import Foundation
import SwiftUI
struct LanguageSelectionView: View {
    private let languages = ["English", "Français"]
    @State private var selectedLanguage: String = LanguageManager.shared.currentLanguage
    
    var body: some View {
        VStack {
            Text("Select a Language:")
                .font(.title)
                .padding()
            List(languages, id: \.self) { language in
                Button(action: {
                    if language == "English" {
                        LanguageManager.shared.setLanguage("en")
                        selectedLanguage = "en" // Update the selected language
                    } else if language == "Français" {
                        LanguageManager.shared.setLanguage("fr")
                        selectedLanguage = "fr" // Update the selected language
                    }
                
                }) {
                    HStack {
                        Text(language)
                        Spacer()
                        if selectedLanguage == "en" && language == "English" {
                            Image(systemName: "checkmark")
                        } else if selectedLanguage == "fr" && language == "Français" {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundColor(.primary)
            }
        }
        .onAppear {
            selectedLanguage = LanguageManager.shared.currentLanguage // Update the selected language when the view appears
        }
    }
}
