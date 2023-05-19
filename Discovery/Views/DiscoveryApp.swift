//
//  DiscoveryApp.swift
//  Discovery
//
//  Created by Discovery on 21/3/2023.
//
import SwiftUI

@main
struct DiscoveryApp: App {
    var body: some Scene {
        WindowGroup {
            
        SplashScreen()
        
       // VerificationOtpScreen(email: .constant(""))
        }
    }
}


/*struct DiscoveryApp: App {
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            LoginScreen()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .onChange(of: colorScheme) { _ in
            isDarkMode = colorScheme == .dark
        }
    }
}*/
