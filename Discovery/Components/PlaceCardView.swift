//
//  PlaceCardView.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//

import Foundation
import SwiftUI
struct PlaceCardView: View {

    @StateObject var  favoritesViewModel=FavoritesViewModel()
    let place:Place
    @State var showModal = false
    @State var VerifFavorite = false
    var body: some View {
        VStack {
            if let url = URL(string: baseUrl+"imgPosts/\(place.photo)") {
                
                AsyncImage(url:url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .padding(.top,10)
                        
                            .clipShape(Rectangle())
                    case .failure(let error):
                        Text(error.localizedDescription)
                    case .empty:
                        Rectangle().foregroundColor(Color .gray).padding(.top,10)
                    @unknown default:
                        Text("Unknown error")
                    }
                } } else {
                    Text("Invalid URL")
                }
        
            Text(place.nom).frame(maxWidth:  .infinity,alignment: .leading)
                .foregroundColor(Color.black)
                .fontWeight(.bold)
       
     
            HStack{
                Image(systemName: "mappin.and.ellipse").foregroundColor(Color.red)
                
                Text(place.lieux).foregroundColor(Color.black)// Set the icon's color
            }.frame(maxWidth:  .infinity,alignment: .leading)
                .padding(.bottom,10)
  
            
     
               
                   
            
     
        
        }   .padding(.horizontal,10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .onTapGesture {
            showModal=true
            let id = UserDefaults.standard.string(forKey: "id")
            let request = Favorite(idPost: place._id, idUser: id!)
            favoritesViewModel.verifFavorite(request: request) { result in
                switch result {
                case .success(let response):
                    // Action si la connexion est réussie
            
                    if(response.message=="Exist!"){
                        VerifFavorite=true
                    }else{
                        VerifFavorite=false
                    }
                    
                    //   self.redirectToHomePage = true // Set redirectToHomePage to true
                case .failure(let error):
                    // Action si la connexion échoue
                    print(error)
                }
                print(request)
            }
        }.sheet(isPresented: $showModal){
            
            PlaceDetailsView(place: place, VerifFavorite: VerifFavorite)
        }
      
    }
    
    
    
}





