//
//  LoginViewModel.swift
//  Discovery
//
//  Created by Discovery on 5/4/2023.
//

import Foundation

import Alamofire

class LoginViewModel: ObservableObject {
    
    var loginRequest: LoginRequest?
    var errorMessage: String?
    
    
    
 
    @Published var email = ""
    @Published var password = ""

    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil


    var isFormValid: Bool {
        return  emailError == nil && passwordError == nil
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
        } else {
            passwordError = nil
        }
    }
    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/user/signin"
        
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
                                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
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
