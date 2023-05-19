//
//  ChangePasswordScreen.swift
//  Discovery
//
//  Created by Discovery on 6/4/2023.
//

import Foundation
import SwiftUI
struct ChangePasswordScreen: View {
    
    @StateObject var changePasswordModel = ChangePasswordModel()
    @State var username: String = ""
    @State var password : String = ""
    @State var isPresenting = false
    @State private var isSnackbarShowing = false
    

    let id = UserDefaults.standard.string(forKey: "id")
    var body: some View {
        NavigationView {
            
        VStack {
     
            Image("changepassword")
                        .resizable()
                        .frame(height: 300)
                        .edgesIgnoringSafeArea(.horizontal)
            Text(LocalizedStringKey("changePassword")).font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading)
                .padding(.bottom,5)
            Section{
            PasswordView(leftIcon : "lock", placeHolder:LocalizedStringKey("password"), password: $changePasswordModel.oldPassword)
                .onChange(of: changePasswordModel.oldPassword) { value in
                    changePasswordModel.validateOldPassword()
                }
            if let errorMessage = changePasswordModel.oldPasswordError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }
            
            Section{
            PasswordView(leftIcon : "lock", placeHolder:LocalizedStringKey("newPassword"), password: $changePasswordModel.newPassword)
                .onChange(of: changePasswordModel.newPassword) { value in
                    changePasswordModel.validateNewPassword()
                }
            if let errorMessage = changePasswordModel.newPasswordError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }
            
            Section{
                PasswordView(leftIcon : "lock", placeHolder:  LocalizedStringKey("confirmPassword"),  password: $changePasswordModel.confirmPassword) .onChange(of: changePasswordModel.confirmPassword) { value in
                    changePasswordModel.validateConfirmPassword()
                }
                if let errorMessage = changePasswordModel.confirmPasswordError {
                    Text(errorMessage)
                        .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
                }}
   
            Button(action: {
                let request = ChangePasswordRequest(_id:id!,username:"",email:"",password:changePasswordModel.oldPassword,newPassword:changePasswordModel.newPassword, bio:"")
  
                changePasswordModel.ChangePassword(request: request) { result in
                 switch result {
                 case .success(let response):
                     if(response.message=="Password Has Changed!"){
                         DispatchQueue.main.async {
                                                     isSnackbarShowing = true
                                                
                                                     // Hide snackbar after duration
                                                     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                         isSnackbarShowing = false
                                                     }
                                                 }
                         isPresenting = true
                         

                            

                     }
                        
                   
               
                 //   self.redirectToHomePage = true // Set redirectToHomePage to true
                 case .failure(let error):
                 // Action si la connexion échoue
                 print(error)
                 }}}
                
                
            ) {
                        Text(LocalizedStringKey("save"))
                            .padding()
                            .foregroundColor(Color.white)
                           
                         
                        
                    }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)

                .foregroundColor(Color.gray)
            
    
          
            Spacer()
     
        }.padding(20).overlay(
            // Add SnackBarView to the view hierarchy
            Snackbar(message: NSLocalizedString("passwordChanged", comment: ""), duration: 0.3, isShowing: $isSnackbarShowing)
                .animation(.easeInOut(duration: 0.3))
                .transition(.move(edge: .bottom))
            , alignment: .bottom
        )
        
        }}   }

struct ChangePasswordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordScreen()
        
    }
    
}
