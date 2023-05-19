//
//  CategoriesViewModel.swift
//  Discovery
//
//  Created by Discovery on 18/4/2023.
//

import Foundation

import Alamofire

class CategoriesViewModel: ObservableObject {
     // Define your base URL here
    
    @Published var categories: [String: [Place]] = [:]
    
    func findPlacesByCategory(category: String) {
        let url = baseUrl+"api/postadmin/FindByCategory/"+category
        
        AF.request(url).responseDecodable(of: [Place].self) { response in
            switch response.result {
            case .success(let places):
                DispatchQueue.main.async {
                    if self.categories[category] == nil {
                        self.categories[category] = []
                    }
                    self.categories[category]?.append(contentsOf: places)
                    self.objectWillChange.send()
                }
       
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
