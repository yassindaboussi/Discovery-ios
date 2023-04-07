//
//  SplashScreen.swift
//  Discovery
//
//  Created by Discovery on 6/4/2023.
//

import Foundation
import SwiftUI
struct SplashScreen: View {
    @State private var isActive = false
    var body: some View {
           
                VStack{
                    
                    Image("logo")
                        .frame(height: 200)
           
                                    }
            
            .onAppear {
                // Ajoutez un délai artificiel pour simuler une tâche d'initialisation
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    isActive = true

                }
            }
            .fullScreenCover(isPresented: $isActive) {
                // Ajoutez votre page d'accueil ici
                NavigationView {
                    
                    LoginScreen()
                }
            }
        }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
