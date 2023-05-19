//
//  Post.swift
//  Discovery
//
//  Created by Discovery on 18/4/2023.
//

import Foundation
import UIKit
struct Post:  Codable,Hashable
{
    let _id: String
    let datepost: String
    let description: String
    let photo: String
    let postedby: User
    let nblike: String
    let reported: String

    let __v: Int
}
