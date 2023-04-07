//
//  SignUpViewModel.swift
//  Discovery
//
//  Created by Discovery on 4/4/2023.
//

import Foundation
import Alamofire

class SignupViewModel: ObservableObject {
    
    var signupRequest: SignupRequest?
    var errorMessage: String?
    
        @Published var username = ""
        @Published var email = ""
        @Published var password = ""
        @Published var confirmPassword = ""

        @Published var usernameError: String? = nil
        @Published var emailError: String? = nil
        @Published var passwordError: String? = nil
        @Published var confirmPasswordError: String? = nil

        var isFormValid: Bool {
            return usernameError == nil && emailError == nil && passwordError == nil
        }

        func validateUsername() {
            if username.isEmpty {
                usernameError = "Username is required"
            } else {
                usernameError = nil
            }
        }

        func validateEmail() {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)

            if email.isEmpty {
                emailError = "Email is required"
            } else if !emailPredicate.evaluate(with: email) {
                emailError = "Email is invalid"
            } else {
                emailError = nil
            }
        }

        func validatePassword() {
            if password.isEmpty {
                passwordError = "Password is required"
            } else if password.count < 8 {
                passwordError = "Password must be at least 8 characters"
            } else {
                passwordError = nil
            }
        }
    func validateConfirmPassword() {
        if confirmPassword.isEmpty {
            confirmPasswordError = "Password is required"
        } else if password != confirmPassword {
            confirmPasswordError = "Passwords must match"
        } else {
            confirmPasswordError = nil
        }
    }

    func signup(request: SignupRequest, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = "http://172.17.2.39:9090/api/user/signup"
        
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
                                
                                let signupResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
                                completion(.success(signupResponse))
                                print(signupResponse)
                               
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
