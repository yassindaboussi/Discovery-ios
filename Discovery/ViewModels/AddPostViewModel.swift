//
//  AddPostViewModel.swift
//  Discovery
//
//  Created by Discovery on 12/4/2023.
//

import Foundation
import Alamofire
import UIKit

class AddPostViewModel: ObservableObject {
    
    @Published var isUploading = false
    @Published var uploadError: Error?
    @Published var inputText = ""
    let id = UserDefaults.standard.string(forKey: "id")
    let token = UserDefaults.standard.string(forKey: "token")
    func uploadPost(image: UIImage, description: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(.failure(NetworkError.invalidImageData))
            return
        }
        
        let headers: HTTPHeaders = [
          //  "Authorization":"Bearer \(token!)",
            "Content-type": "multipart/form-data"        ]
        
        let parameters = ["description": description,"postedby":id!]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: baseUrl+"api/postuser/AddPostUser", headers: headers)
        .validate()
        .response { response in
            switch response.result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidImageData
}
