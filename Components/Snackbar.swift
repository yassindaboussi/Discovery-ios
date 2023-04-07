//
//  Snackbar.swift
//  Discovery
//
//  Created by Discovery on 6/4/2023.
//

import Foundation
import SwiftUI



struct Snackbar: View {
    let message: String
    let duration: Double
    @Binding var isShowing: Bool
    let skyBlue = Color(red: 50/255, green:222/255, blue: 132/255)
    var body: some View {
        VStack {
            Text(message)
                .foregroundColor(.white)
        }
        .padding()
        .background(skyBlue)
        .cornerRadius(8)
        .opacity(isShowing ? 1 : 0)
        .animation(.easeInOut(duration: duration))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                withAnimation {
                    self.isShowing = false
                }
            }
        }
    }
}
