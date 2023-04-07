//
//  ProfileEdit.swift
//  Discovery
//
//  Created by Discovery on 7/4/2023.
//

import Foundation
import SwiftUI


struct ProfileEditView: View {
    @State var isPresenting = false

    let username = UserDefaults.standard.string(forKey: "username")
    let bio = UserDefaults.standard.string(forKey: "bio")
    let email = UserDefaults.standard.string(forKey: "email")

    
    var body: some View {

            VStack {
                    Image("editprofil")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 15)
                
                Text("About Me")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.black)
                    .padding(.top, 20)
                    .frame(maxWidth:.infinity, alignment:.leading)
                    .padding(.leading, 5)
                
                HStack {
                    Text("Nom")
                        .font(.system(size: 17))
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text(username!)
                        .font(.system(size: 17))
                        .foregroundColor(Color.black)
                   
                    
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color.black)
                }
                .padding(10)

                HStack {
                    Text("Email")
                        .font(.system(size: 17))
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text(email!)
                        .font(.system(size: 17))
                        .foregroundColor(Color.black)
                        .padding(.trailing, 5)
                    
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color.black)
                }
                .padding(10)

                HStack {
                    Text("Bio")
                        .font(.system(size: 17))
                        .foregroundColor(Color.black)
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    Text(bio!)
                        .font(.system(size: 17))
                        .foregroundColor(Color.black)
                
                    
                    Image(systemName: "arrow.forward")
                        .foregroundColor(Color.black)
                    
                }
                .padding(10)
                
                Divider()

                HStack {
                    Text("Change Passsword?")
                        .font(.system(size: 17))
                        .foregroundColor(Color.blue)
                        .padding(.leading, 5)
                        .onTapGesture {
                            isPresenting = true

                        }
                    NavigationLink(destination: ChangePasswordScreen().navigationBarBackButtonHidden(false), isActive: $isPresenting) { EmptyView() }

                    Spacer()
                    
                }
                .padding(10)
                
                Spacer()

            }.padding(10)

        }
    }


