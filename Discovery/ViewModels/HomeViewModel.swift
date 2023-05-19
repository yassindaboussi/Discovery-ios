//
//  HomeViewModel.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//

import Foundation
import Alamofire
class HomeViewModel: ObservableObject {
    @Published var places: [Place] = []
    
    func fetchPlaces(completion: @escaping ([Place]?) -> Void) {
        AF.request(baseUrl+"api/postadmin/SortbyRate").responseDecodable(of: [Place].self) { response in
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
}
