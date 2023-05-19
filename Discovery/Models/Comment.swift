//
//  Comment.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation
import UIKit
struct Comment:  Codable,Hashable
{
    let _id: String
    let content: String
    let postId: String
    let userId: UserResponse
    let date: String
    let __v: Int
}

struct UserResponse:  Codable,Hashable
{
    let _id: String
    let username: String
    let avatar: String

}

struct Comments:  Codable,Hashable
{
    let count: Int
    let commentaires: [Comment]

}
struct CommentRequest: Codable {
    let idPost: String
    let idUser: String
    let content: String

}
struct CommentReponse: Codable {
    let _id: String
    let content: String
    let postId: String
    let userId: String
    let date: String
    let __v: Int

}
