//
//  ChangePasswordViewModel.swift
//  Discovery
//
//  Created by Discovery on 6/4/2023.
//

import Foundation

import Foundation
import Alamofire
class ChangePasswordModel: ObservableObject {
    
    
    
    
        @Published var oldPassword = ""
        @Published var newPassword = ""
        @Published var confirmPassword = ""


        @Published var oldPasswordError: String? = nil
        @Published var newPasswordError: String? = nil
        @Published var confirmPasswordError: String? = nil



      

        func validateOldPassword() {
            if oldPassword.isEmpty {
                oldPasswordError = "Old password is required"
            }else {
                oldPasswordError = nil
            }
        }
    
    func validateNewPassword() {
        if newPassword.isEmpty {
            newPasswordError = "New password is required"
        } else if oldPassword.count < 8 {
            newPasswordError = "New password must be at least 8 characters"
        } else {
            newPasswordError = nil
        }
    }
    
    func validateConfirmPassword() {
        if confirmPassword.isEmpty {
            confirmPasswordError = "Confirm password is required"
        } else if newPassword != confirmPassword {
            confirmPasswordError = "Passwords must match"
        } else {
            confirmPasswordError = nil
        }
    }
    
    
    
    func ChangePassword(request: ChangePasswordRequest, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/user/EditProfil"
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .post)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            do {
                                let loginResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
                                completion(.success(loginResponse))
                                print(loginResponse)
                            } catch {
                                print(error)
                                completion(.failure(error))
                            }
                        case .failure(let error):
                            print(error)
                            completion(.failure(error))
                    }
                }
        } catch {
            print(error)
            completion(.failure(error))
        }
        // default return statement
        return AF.request(url)
    }
   
    
    
    
   
}
