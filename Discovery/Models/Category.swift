//
//  Category.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import Foundation
struct Category: Hashable {
    let gif: String
    let title: String

}
struct CategoryRequest: Encodable {
    let categorie: String

}
