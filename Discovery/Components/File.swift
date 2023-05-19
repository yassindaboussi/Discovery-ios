//
//  File.swift
//  Discovery
//
//  Created by Discovery on 10/5/2023.
//

import Foundation
import SwiftUI
struct wii: View {
    var body: some View {
        NavigationView {
            LoginScreen()
                .navigationTitle("My App")
                .navigationBarItems(trailing:
                    NavigationLink(destination: LanguageSelectionView()) {
                        Text("Settings")
                    }
                )
        }
    }
}
