//
//  ForgetPasswordScreen.swift
//  Discovery
//
//  Created by Discovery on 1/4/2023.
//

import Foundation

import SwiftUI
struct ForgetPasswordScreen: View {
    @State var isPresenting = false
    @StateObject var forgetPasswordViewModel = ForgetPasswordModel()
    @State var emailAddress : String = ""
    var body: some View {
        NavigationView {
            
        VStack {
     
            Image("forgotpassword")
                        .resizable()
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.horizontal)
            
            
            Text(NSLocalizedString("forgetPassword",comment:"Forget password ?")).font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading)
                .padding(.bottom,5)
            
            Text(NSLocalizedString("dontWoory",comment:"Don't worry ! It happens.Please enter the adress associted with your account"))
                .frame(maxWidth:.infinity, alignment:.leading)
                .foregroundColor(Color.gray)
            
            Section{
                CustumTextField(leftIcon : "envelope",placeHolder : "Email", text: $forgetPasswordViewModel.email)
                    .onChange(of: forgetPasswordViewModel.email) { value in
                        forgetPasswordViewModel.validateEmail()
                    }
                if let errorMessage = forgetPasswordViewModel.emailError {
                    Text(errorMessage)
                        .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                }
            }
      //  TextFieldView(leftIcon : "envelope",placeHolder : "Email", text: $emailAddress)
                            
        
            Button(action: {
    
                let request = SendMailRequest(email: forgetPasswordViewModel.email)
                forgetPasswordViewModel.sendEmail(request: request) { result in
                    switch result {
                    case .success(let response):
                        if(response == "Email not found"){
                            isPresenting = false
                        }
                        else if(response == "Verification code sent sucessfully"){
                           
                            isPresenting = true
                        }
                        else{
                            isPresenting = false
                        }
                        // Action si la connexion est réussie
                        print(response)
            
                     //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }
                }
                    }) {
                        Text(NSLocalizedString("send",comment: "Send"))
                            .padding()
                            .foregroundColor(Color.white)
                           
                         
                        
                    }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)
    
                .foregroundColor(Color.gray)
            
            NavigationLink(destination: VerificationOtpScreen(email: $forgetPasswordViewModel.email).navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
            Spacer()
            HStack{
       
                Text(NSLocalizedString("backTo",comment: "Back to?")).foregroundColor(Color.gray)
                    NavigationLink(destination: SignUpScreen()) {
                        Text(NSLocalizedString("login",comment: "Login")).foregroundColor(Color.red)
                    
                    }}
        }.padding(20)
        
        }}   }

struct ForgetPasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordScreen()
    }
}
