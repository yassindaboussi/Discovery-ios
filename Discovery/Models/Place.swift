//
//  Place.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//

import Foundation
import UIKit

struct Place: Codable,Hashable, Identifiable {
    let _id: String
    let nom: String
    let lieux: String
    let rate: String
    let nbOfrate: Int
    let photo: String
    let categorie: String
    let description: String
    let __v:Int

    var id : String {_id}
    

}

