//
//  AddPlaceViewModel.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//


import Foundation

import Alamofire
import UIKit

class AddPlaceViewModel: ObservableObject {
    

    
    
    
    
 
    @Published var nom = ""
    @Published var lieux  = ""
    @Published var description = ""
    @Published var categorie  = ""

    @Published var titleError: String? = nil
    @Published var placeError: String? = nil
    @Published var descriptionError: String? = nil
    @Published var categoryError: String? = nil

    var isFormValid: Bool {
        return  titleError == nil && placeError == nil
    }



    func validateTitle() {


        if nom.isEmpty {
            titleError = "Title is required"
        } else {
            titleError = nil
        }
    }

    func validatePlace() {
        if lieux.isEmpty {
            placeError = "Place is required"
        } else {
            placeError = nil
        }
    }
    
    
    
    func validateDescription() {


        if description.isEmpty {
            descriptionError = "Description is required"
        } else {
            descriptionError = nil
        }
    }
    
    
    func validateCategory() {


        if categorie.isEmpty {
            categoryError = "Category is required"
        } else {
            categoryError = nil
        }
    }
    
    func addPlace(photo: UIImage, nom: String, lieux: String, categorie: String, description: String, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
            
        guard let imageData = photo.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NetworkError.invalidImageData))
            return
        }
            
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
            
        let parameters = ["nom":nom,"lieux":lieux,"categorie":categorie,"description": description]
            
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "photo", fileName: "image.jpg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: baseUrl+"api/postadmin/AddPostAdmin", headers: headers)
        .validate()
        .response { response in
            switch response.result {
            case .success(let data):
                if let responseData=data{
                    do {
                        let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: responseData )
                        completion(.success(messageResponse))
                    } catch {
                        completion(.failure(error))
                    }
                }else{
                    completion(.failure(NetworkError.invalidImageData))
                }
             
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
