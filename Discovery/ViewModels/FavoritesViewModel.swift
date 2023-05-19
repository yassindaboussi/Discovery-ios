//
//  FavoritesViewModel.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import Foundation
import Alamofire
class FavoritesViewModel: ObservableObject {
    @Published var places: [Place] = []
    let id = UserDefaults.standard.string(forKey: "id")
    func fetchPlaces(completion: @escaping ([Place]?) -> Void) {
        
        
        AF.request(baseUrl+"api/favorite/FavoritefindByUser/"+id!).responseDecodable(of: [Place].self) { response in
            switch response.result {
            case .success(let places):
                completion(places)
                self.places=places
                print(places)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    
    
    func addFavorite(request: Favorite, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/favorite/AddFavorite"
        
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
    
    func verifFavorite(request: Favorite, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/favorite/VerifFavorite"
        
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
    
    
    
    
    func deleteFavorite(request: Favorite, completion: @escaping (Result<MessageResponse, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/favorite/FavoriteDelete"
        
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
    
}
