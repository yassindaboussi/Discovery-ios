//
//  LoginScreen.swift
//  Discovery
//
//  Created by Discovery on 1/4/2023.
//

import Foundation
import LocalAuthentication
import SwiftUI
import SwiftUISnackbar

struct LoginScreen: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @State var isPresenting = false
    @State private var loginSuccess = false
    @State private var isSnackbarShowing = false
    @State private var snackbarMessage=""
    @StateObject var store = SnackbarStore()
    //
    let email = UserDefaults.standard.string(forKey: "email")
    let password = UserDefaults.standard.string(forKey: "password")
    @State var role :String = ""

    //
    @State private var faceIDAuthenticationResult: Bool? = nil
    @State private var isUnlocked = false
    @State private var showAlert = false
    //
    var body: some View {
        NavigationView {
            
        VStack {
     
            Image("femmetransp")
                        .resizable()
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.horizontal)
            Section{
                CustumTextField(leftIcon : "envelope",placeHolder :LocalizedStringKey("email"), text: $loginViewModel.email)
                    .onChange(of: loginViewModel.email) { value in
                        loginViewModel.validateEmail()
                    }
                if let errorMessage = loginViewModel.emailError {
                    Text(errorMessage)
                        .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                }
            }
                
    
          
            Section{
            PasswordView(leftIcon : "lock", placeHolder :LocalizedStringKey("password"), password: $loginViewModel.password)
                .onChange(of: loginViewModel.password) { value in
                    loginViewModel.validatePassword()
                }
            if let errorMessage = loginViewModel.passwordError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }

            HStack{
   
                Spacer()
                    NavigationLink(destination: ForgetPasswordScreen()) {
                        Text(LocalizedStringKey("forgetPassword")).foregroundColor(Color.red)
                    }}
            
            Button(action: {
                if isUnlocked {

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
                  
                            UserDefaults.standard.set(response.id, forKey: "id")
                            UserDefaults.standard.set(response.name, forKey: "username")
                            UserDefaults.standard.set(response.email, forKey: "email")
                            UserDefaults.standard.set(response.bio, forKey: "bio")
                            UserDefaults.standard.set(response.avatar, forKey: "avatar")
                            UserDefaults.standard.set(response.role, forKey: "role")
                            UserDefaults.standard.set(response.token, forKey: "token")
                            print(response.token)
                        self.role = response.role

                        //   self.redirectToHomePage = true // Set redirectToHomePage to true
                       case .failure(let error):
                           // Action si la connexion échoue
                           print(error)
                       }
                   }
               } else {
                   Text("Please authenticate with Face ID")
                   showAlert = true
               }
                    }) {
                        Text(NSLocalizedString("login", comment: "Login"))
                            .padding()
                            .foregroundColor(Color.white)
                           
                         
                        
                    }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)
                .foregroundColor(Color.gray)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Alert"),
                        message: Text("You need to authenticate with Face ID first"),
                        primaryButton: .default(Text("OK")),
                        secondaryButton: .cancel()
                    )
                }
            
            Button(action: authenticateWithBiometrics) {
              Image(systemName: "faceid")
                  .resizable()
                  .frame(width: 50, height: 50)
           }
            
            if isUnlocked {
                Text("Authenticated successfully!")
            } else {
                Text("Please authenticate with Face ID")
            }
          //  NavigationLink(destination: BottomNavigation().navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
            if(role == "User"){
                // Key exists in UserDefaults
                NavigationLink(destination: BottomNavigation().navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
            }else if(role == "Admin"){
                NavigationLink(destination:HomeScreen().navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
              
            }
            Spacer()
            HStack{
       
                Text(LocalizedStringKey("newToDiscovery")).foregroundColor(Color.gray)
                    NavigationLink(destination: SignUpScreen().navigationBarBackButtonHidden(true)) {
                        Text(LocalizedStringKey("joinNow")).foregroundColor(Color.red)
                    
                    }}
        }.padding(20).overlay(
            // Add SnackBarView to the view hierarchy
            Snackbar(message:"Login Successful", duration: 0.3, isShowing:  $isSnackbarShowing)
                //.animation(.easeInOut(duration: 0.3))
                .transition(.move(edge: .bottom))
                //.padding(.bottom, 30)
            , alignment: .bottom
        )
        
        }}
    
    
    
    private func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        // Check if Face ID is available on the device and the user has granted permission
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in with Face ID"
            // Prompt the user to authenticate with Face ID
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    // User authenticated successfully
                    DispatchQueue.main.async {
                        isUnlocked = true
                    }
                    print("User authenticated successfully")
                    
                } else {
                    // Authentication failed
                    print(error?.localizedDescription ?? "Authentication failed")
                }
            }
        } else {
            // Face ID is not available or the user has not granted permission
            print(error?.localizedDescription ?? "Face ID not available")
        }
    }
    
}






