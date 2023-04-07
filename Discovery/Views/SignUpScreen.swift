//
//  SignUpScreen.swift
//  Discovery
//
//  Created by Discovery on 21/3/2023.
//

import Foundation
import SwiftUI
struct SignUpScreen: View {
    
    
   // @StateObject var signViewModel = SignupViewModel()
    @StateObject var signViewModel = SignupViewModel()
    var body: some View {

            VStack {
                Image("imgsignup")
                    .resizable()
                    .frame(height: 200)
                    .edgesIgnoringSafeArea(.horizontal)
                Section{
                    TextFieldView(leftIcon : "person",placeHolder : "Username", text: $signViewModel.username)
                        .onChange(of: signViewModel.username) { value in
                            signViewModel.validateUsername()
                        }
                    if let errorMessage = signViewModel.usernameError {
                        Text(errorMessage)
                            .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                    }
                }
                Section{
                    TextFieldView(leftIcon : "envelope",placeHolder : "Email", text: $signViewModel.email)
                        .onChange(of: signViewModel.email) { value in
                            signViewModel.validateEmail()
                        }
                    if let errorMessage = signViewModel.emailError {
                        Text(errorMessage)
                            .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                    }
                }
                    
                
              
                Section{
                PasswordView(leftIcon : "lock", placeHolder:"Password", password: $signViewModel.password)
                    .onChange(of: signViewModel.password) { value in
                        signViewModel.validatePassword()
                    }
                if let errorMessage = signViewModel.passwordError {
                    Text(errorMessage)
                        .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                }   }
                Section{
                    PasswordView(leftIcon : "lock", placeHolder:  "Confirm password",  password: $signViewModel.confirmPassword) .onChange(of: signViewModel.confirmPassword) { value in
                        signViewModel.validateConfirmPassword()
                    }
                    if let errorMessage = signViewModel.confirmPasswordError {
                        Text(errorMessage)
                            .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                    }}
                Button(action: {
                    let request = SignupRequest(username:signViewModel.username,email:signViewModel.email, password:signViewModel.password)
                    signViewModel.signup(request: request) { result in
                        switch result {
                        case .success(let response):
                            // Action si la connexion est réussie
                            print(response)
                            
                            //   self.redirectToHomePage = true // Set redirectToHomePage to true
                        case .failure(let error):
                            // Action si la connexion échoue
                            print(error)
                        }
                    }
                }) {
                    Text("Sign Up")
                        .padding()
                        .foregroundColor(Color.white)
                    
                    
                    
                }    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.top,20)
        
                Spacer()
                HStack{
                    
                    Text("Already have an account ?").foregroundColor(Color.gray)
                    NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true)) {
                        Text("Login ").foregroundColor(Color.red)
                        
                    }}
                
            }.padding(20)
            
        }
    }
    
    
    



struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
