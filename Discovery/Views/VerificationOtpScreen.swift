//
//  VerificationOtpScreen.swift
//  Discovery
//
//  Created by Discovery on 5/4/2023.
//

import Foundation

import SwiftUI
struct VerificationOtpScreen: View {
    @Binding var email:String
    @StateObject var forgetPasswordModel = ForgetPasswordModel()
    @State var otp: String = ""
    @State var isPresenting = false
    var body: some View {
        NavigationView {
            
        VStack {
     
            Image("codeotp")
                        .resizable()
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.horizontal)
            
            
            Text("Verification code").font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading)
                .padding(.bottom,5)
            
            Text("We have send code to your e-mail,please type the code")
                .frame(maxWidth:.infinity, alignment:.leading)
                .foregroundColor(Color.gray)
            OTPInputView(otp: $otp)
            HStack{
       
                Text("Didn't receive the code?").foregroundColor(Color.gray)
            
                        Text("Resend").foregroundColor(Color.red)
                    
                    }
            Button(action: {
                
                let request = VerifyCodeRequest(email:email, codeForget: otp)
                print(email)
                forgetPasswordModel.VerifyCodeOtp(request: request) { result in
                    switch result {
                    case .success(let response):
                        // Action si la connexion est réussie
                        print(response)
                        
                        if(response.message == "Code Has been verified!"){
                            isPresenting = true  
                        }
                        else if(response.message == "Sorry! There is no code in Database!"){
                            isPresenting = false
                        }
                        else if(response.message == "Sorry! The code is incorrect!"){
                            isPresenting = false
                       
                        }
                        print(response)
                        
            
                     //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }
                }
                print(otp)
        
                
                    }) {
                        Text("Verify")
                            .padding()
                            .foregroundColor(Color.white)
                           
                         
                        
                    }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)
    
                .foregroundColor(Color.gray)
            NavigationLink(destination: ResetPasswordScreen(email: $email, otp:$otp).navigationBarBackButtonHidden(true), isActive: $isPresenting) { EmptyView() }
            Spacer()
            HStack{
       
                Text("Back to ?").foregroundColor(Color.gray)
                    NavigationLink(destination: SignUpScreen()) {
                        Text("Login").foregroundColor(Color.red)
                    
                    }}

        }.padding(20)
        
        }}   }

struct VerificationOtpScreen_Previews: PreviewProvider {
    static var previews: some View {
        VerificationOtpScreen(email: .constant(""))
    }
}
