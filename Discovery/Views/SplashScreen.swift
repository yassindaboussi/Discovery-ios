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
                        .scaleEffect(isActive ? 1.0 : 0.5) // Add scale effect animation to the image
                        .animation(.easeInOut(duration: 1.0)) // Add animation to the scale effect
                                    }
            
            .onAppear {
                // Ajoutez un délai artificiel pour simuler une tâche d'initialisation
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    isActive = true

                }
            }
            .fullScreenCover(isPresented: $isActive) {
                // Ajoutez votre page d'accueil ici
                NavigationView {
                    
                    let value = UserDefaults.standard.object(forKey: "role")

       
                    if value != nil {
                        let role = UserDefaults.standard.string(forKey: "role")
                        if(role == "User"){
                            // Key exists in UserDefaults
                            NavigationLink(destination: BottomNavigation().navigationBarBackButtonHidden(true), isActive: $isActive) { EmptyView() }
                        }else if(role == "Admin"){
                            NavigationLink(destination:HomeScreen().navigationBarBackButtonHidden(true), isActive: $isActive) { EmptyView() }
                          
                        }
        
         
                    } else {
                      
                        // Key does not exist in UserDefaults
                        LoginScreen()
                    }
                 
                }
            }
        }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
