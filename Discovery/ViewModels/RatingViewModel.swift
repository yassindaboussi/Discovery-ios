//
//  RatingViewModel.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation
import Alamofire

class RatingViewModel: ObservableObject {
    @Published var rating : Int=0
    func getratingByUserId(postId: String,userId:String) {
        let url = baseUrl+"api/rating/getRate/"+postId+"/"+userId
        
        AF.request(url).responseDecodable(of: Rating.self) { response in
            switch response.result {
            case .success(let rating):
             
              
                self.rating=rating.rating

       
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addRating(request: RatingRequest, completion: @escaping (Result<Place, Error>) -> ()) -> DataRequest {
        let url = baseUrl+"api/rating/ratePost/"+request.idPost+"/"+request.idUser
        
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
                                
                                let place = try JSONDecoder().decode(Place.self, from: data)
                                completion(.success(place))
                                print(place)
                               
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
