//
//  CommentsViewModel.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation
import Alamofire

class CommentsViewModel: ObservableObject {
     // Define your base URL here
    @Published var comment = ""
    @Published var comments: [Comment] = [] 
    @Published var count: Int=0
    func getCommentsByIdPost(postId: String) {
        let url = baseUrl+"api/commentaire/"+postId
        
        AF.request(url).responseDecodable(of: Comments.self) { response in
            switch response.result {
            case .success(let comments):
             
                self.comments=comments.commentaires
                self.count=comments.count
                print(comments.count)
       
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addComment(request: CommentRequest, completion: @escaping (Result<CommentReponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/commentaire/"+request.idPost+"/"+request.idUser
        
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
                                
                                let messageResponse = try JSONDecoder().decode(CommentReponse.self, from: data)
                                completion(.success(messageResponse))
                                print(messageResponse)
                               
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
