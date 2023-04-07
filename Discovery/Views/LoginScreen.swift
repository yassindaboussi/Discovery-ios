//
//  LoginScreen.swift
//  Discovery
//
//  Created by Discovery on 1/4/2023.
//

import Foundation

import SwiftUI
import SwiftUISnackbar

struct LoginScreen: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @State var isPresenting = false
    @State var isChecked = false
    @State private var loginSuccess = false
    @State private var isSnackbarShowing = false
    @State private var snackbarMessage=""
    @StateObject var store = SnackbarStore()
    //
    let email = UserDefaults.standard.string(forKey: "email")
    let password = UserDefaults.standard.string(forKey: "password")

    //
    
    var body: some View {
        NavigationView {
            
        VStack {
     
            Image("femmetransp")
                        .resizable()
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.horizontal)
            Section{
                TextFieldView(leftIcon : "envelope",placeHolder : "Email", text: $loginViewModel.email)
                    .onChange(of: loginViewModel.email) { value in
                        loginViewModel.validateEmail()
                    }
                if let errorMessage = loginViewModel.emailError {
                    Text(errorMessage)
                        .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                }
            }
                
            
          
            Section{
            PasswordView(leftIcon : "lock", placeHolder:"Password", password: $loginViewModel.password)
                .onChange(of: loginViewModel.password) { value in
                    loginViewModel.validatePassword()
                }
            if let errorMessage = loginViewModel.passwordError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }

            HStack{
                CheckboxToggle(isChecked:$isChecked)
                Spacer()
                    NavigationLink(destination: ForgetPasswordScreen()) {
                        Text("Forget password ?").foregroundColor(Color.red)
                    
                    }}
            
            Button(action: {
                let request = LoginRequest(email: loginViewModel.email, password: loginViewModel.password)
                loginViewModel.login(request: request) { result in
                    switch result {
                    case .success(let response):
                        // Action si la connexion est réussie
                        DispatchQueue.main.async {
                                                    isSnackbarShowing = true
                                                    // Hide snackbar after duration
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        isSnackbarShowing = false
                                                    }
                                                }
                        isPresenting = true
                        if isChecked {
                                            // Store user's credentials in UserDefaults
                            UserDefaults.standard.set(response.id, forKey: "id")
                            UserDefaults.standard.set(response.name, forKey: "username")
                            UserDefaults.standard.set(response.email, forKey: "email")
                            UserDefaults.standard.set(response.bio, forKey: "bio")
                            UserDefaults.standard.set(response.avatar, forKey: "avatar")
                                  
                                        }

                     //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }
                }
                    }) {
                        Text("Login")
                            .padding()
                            .foregroundColor(Color.white)
                           
                         
                        
                    }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)
                .foregroundColor(Color.gray)
            
            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }

            Spacer()
            HStack{
       
                Text("New to Discovery ?").foregroundColor(Color.gray)
                    NavigationLink(destination: SignUpScreen().navigationBarBackButtonHidden(true)) {
                        Text("Join Now").foregroundColor(Color.red)
                    
                    }}
        }.padding(20).overlay(
            // Add SnackBarView to the view hierarchy
            Snackbar(message:"Login Successful", duration: 0.3, isShowing:  $isSnackbarShowing)
                //.animation(.easeInOut(duration: 0.3))
                .transition(.move(edge: .bottom))
                //.padding(.bottom, 30)
            , alignment: .bottom
        )
        
        }}   }

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
