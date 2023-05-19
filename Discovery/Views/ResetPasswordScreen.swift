//
//  ResetPasswordScreen.swift
//  Discovery
//
//  Created by Discovery on 5/4/2023.
//

import Foundation

import SwiftUI
struct ResetPasswordScreen: View {
    
    @StateObject var forgetPasswordModel = ForgetPasswordModel()
    @State var username: String = ""
    @Binding var email:String
    @Binding var otp:String
    @State var password : String = ""
    @State var isPresenting = false
    var body: some View {
        NavigationView {
            
        VStack {
     
            Image("changepassword")
                        .resizable()
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.horizontal)
            Text(LocalizedStringKey("resetPassword")).font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading)
                .padding(.bottom,5)
            Section{
            PasswordView(leftIcon : "lock", placeHolder:LocalizedStringKey("password"), password: $forgetPasswordModel.password)
                .onChange(of: forgetPasswordModel.password) { value in
                    forgetPasswordModel.validatePassword()
                }
            if let errorMessage = forgetPasswordModel.passwordError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }
            Section{
                PasswordView(leftIcon : "lock", placeHolder:  LocalizedStringKey("confirmPassword"),  password: $forgetPasswordModel.confirmPassword) .onChange(of: forgetPasswordModel.confirmPassword) { value in
                    forgetPasswordModel.validateConfirmPassword()
                }
                if let errorMessage = forgetPasswordModel.confirmPasswordError {
                    Text(errorMessage)
                        .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                }}
   
            Button(action: {
                let request = ResetPasswordRequest(email:email, codeForget: otp,password:forgetPasswordModel.password)
                print(email)
                forgetPasswordModel.ResetPassword(request: request) { result in
                    switch result {
                    case .success(let response):
                        if(response.message ==  "Congratulations, Password changed!"){
                            isPresenting = true
                        }
                        else {
                            isPresenting = false
                        }
                        
                        //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }}}) {
                        Text(  LocalizedStringKey("save"))
                            .padding()
                            .foregroundColor(Color.white)
                           
                         
                        
                    }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)

                .foregroundColor(Color.gray)
            NavigationLink(destination: LoginScreen().navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
            Spacer()
            HStack{
       
                Text(LocalizedStringKey("backTo")).foregroundColor(Color.gray)
                    NavigationLink(destination: LoginScreen()) {
                        Text(LocalizedStringKey("Login")).foregroundColor(Color.red)
                            .navigationBarBackButtonHidden(true)
                    
                    }}
        }.padding(20)
        
        }}   }

struct ResetPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordScreen(email: .constant(""), otp: .constant(""))
        
    }
    
}
