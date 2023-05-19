//
//  PostsViewModel.swift
//  Discovery
//
//  Created by Discovery on 18/4/2023.
//

import Foundation
import Alamofire
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var mypost: [MyPost] = []
    init() {

        fetchPosts()
    }
    func fetchPosts() {
        
        
        AF.request(baseUrl+"api/postuser/all").responseDecodable(of: [Post].self) { response in
            switch response.result {
            case .success(let posts):
               // completion(posts)
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                                self.posts = posts
                            }
                print(posts)
            case .failure(let error):
                print(error.localizedDescription)
                //completion(nil)
            }
        }
    }
    
    
    func addLike(request: Like, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/like/AddLike";
        
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
                                
                                let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
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
    
    func deleteLike(request: Like, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/like/DeleteLike/"+request.idPost+"/"+request.idUser;
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            var urlRequest = try URLRequest(url: url, method: .delete)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = encodedRequest
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            do {
                                
                                let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
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
    
    
    func verifLike(request: Like, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/like/VerifLike/"+request.idPost+"/"+request.idUser;
        
        do {
           
            var urlRequest = try URLRequest(url: url, method: .get)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            do {
                                
                                let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: data)
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
    
    func countLikesByPost(postId: String, completion: @escaping (Result<Count, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/like/CountLikes/"+postId;
        
        do {
           
            var urlRequest = try URLRequest(url: url, method: .get)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<500)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                        case .success(let data):
                            do {
                                
                                let count = try JSONDecoder().decode(Count.self, from: data)
                                completion(.success(count))
                                print(count)
                               
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
    
    
    
    
    func getPostssss(postedby: String) {
      // Create the request
      let url = URL(string: baseUrl+"api/postuser/GetAllMyPost")!
      let parameters: [String: Any] = [
        "postedby": postedby
      ]

      // Send the request
      AF.request(url, method: .post, parameters: parameters).response { response in
        switch response.result {
        case .success(let data):
          do {
              print(data)
            let mypost = try JSONDecoder().decode([MyPost].self, from: data!)
              //print("succ ",data)
              self.mypost = mypost
          } catch {
            print(error)
          }
        case .failure(let error):
          print(error)
        }
      }
    }
}
