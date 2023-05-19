//
//  Rating.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation
struct RatingRequest: Codable {
    let idPost: String
    let idUser: String
    let rating: String

}
struct Rating: Codable {
    let _id: String
    let postId: String
    let userId: String
    let rating: Int
    let date:String
    let __v:Int

}
