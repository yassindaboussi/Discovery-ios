//
//  User.swift
//  Discovery
//
//  Created by Discovery on 5/4/2023.
//

import Foundation

struct SignupRequest: Encodable {
    let username: String
    let email: String
    let password: String
}

struct MessageResponse: Decodable {
    let message: String
}
struct ErrorResponse: Decodable {
    let error: String
}

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let id: String
    let name: String
    let email: String
    let bio: String
    let avatar: String
    let token: String
    let role: String
}

struct SendMailRequest: Encodable {
    let email: String
}

struct VerifyCodeRequest: Encodable {
    let email: String
    let codeForget: String
}
struct ResetPasswordRequest: Encodable {
    let email: String
    let codeForget: String
    let password: String
}
struct ChangePasswordRequest: Encodable {
    let _id: String
    let username: String
    let email: String
    let password: String
    let newPassword: String
    let bio: String
}
struct User:Codable,Hashable {
    let _id: String
    let username: String
    let email: String
    let password: String
    let role: String
    let avatar: String
    let bio: String
    let codeVerif: String
    let verified: String

    let __v: Int
}
