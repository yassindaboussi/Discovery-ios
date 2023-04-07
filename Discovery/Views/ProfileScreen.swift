//
//  ProfileScreen.swift
//  Discovery
//
//  Created by Discovery on 6/4/2023.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @State var isPresenting = false

    
    let colororange = Color(red: 255/255, green:99/255, blue: 102/255)
    let username = UserDefaults.standard.string(forKey: "username")
    let bio = UserDefaults.standard.string(forKey: "bio")

    
    var body: some View {
        ZStack {
            // Half circle background
            GeometryReader { geo in
                Path { path in
                    let width = geo.size.width
                    let height = geo.size.height
                    path.move(to: CGPoint(x: 0, y: height/2))
                    path.addQuadCurve(to: CGPoint(x: width, y: height/2), control: CGPoint(x: width/2, y: -height/4))
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(Color(#colorLiteral(red: 0.08235294118, green: 0.1098039216, blue: 0.168627451, alpha: 1)))
            }
            .frame(height: 400)
            .offset(y:150)
            .rotationEffect(.degrees(180))
            .padding(.bottom, 50)
            
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding(.top, 50)
                
                Text(username!)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                
                Text(bio!)
                    .foregroundColor(.gray)
                    .font(.headline)
                
                
                Text("Edit Profile")
                    .font(.system(size: 11))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.black)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 100)
                    .padding(.top, 15)
                    .onTapGesture {
                        print("edit")
                        isPresenting = true

    
                    }
                NavigationLink(destination: ProfileEditView().navigationBarBackButtonHidden(false), isActive: $isPresenting) { EmptyView() }
                HStack {
                    Spacer()
                    
                    Text("PHOTOS")
                        .font(.system(size: 22))
                        .font(.headline)
                        .foregroundColor(colororange)

                    
                    Spacer()
                    
                }
                .padding(.top, 10)
                
                Divider()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(1..<10) { index in
                            HStack {
                                
                                
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
    
}
