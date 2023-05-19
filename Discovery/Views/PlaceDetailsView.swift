//
//  PlaceDetailsView.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import Foundation
import SwiftUI

struct PlaceDetailsView: View {
    let place: Place
    let VerifFavorite:Bool
    let height = UIScreen.main.bounds.height
    @State private var isRatingDialogPresented = false
    @State private var isMapDialogPresented = false

    @State var added=false
    @StateObject var  favoritesViewModel=FavoritesViewModel()
    
    @State private var qrCodeData: String = ""
    
    var body: some View {
        
        VStack(alignment:.center){
            ZStack(alignment: .bottomLeading) {
                HStack{
            
              
                    if let url = URL(string: baseUrl+"imgPosts/\(place.photo)") {
                        
                        AsyncImage(url:url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                
                            
                                    .clipShape(Rectangle())
                    
                            case .failure(let error):
                                Text(error.localizedDescription)
                            case .empty:
                                Rectangle().foregroundColor(Color .gray)
                            @unknown default:
                                Text("Unknown error")
                            }
                        }.frame(height: height/3) } else {
                            Text("Invalid URL")
                        }
                    
                }
                if(VerifFavorite==false){
                    Button(action: {
                        let id = UserDefaults.standard.string(forKey: "id")
                        let request = Favorite(idPost: place._id, idUser: id!)
                        favoritesViewModel.addFavorite(request: request) { result in
                            switch result {
                            case .success(let response):
                                // Action si la connexion est réussie
                                print(response)
                                added.self=true
                                
                                //   self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
                            }
                            print(request)
                        }
                  
                    }) {
                 
                            Image(systemName: "heart.fill")
                                .foregroundColor(added ? Color.red:Color.white)
                                .padding(10)
                                .font(.system(size: 40))
               
                        
                    }
                    
                  
                    .padding(10)
                }else{
                    Button(action: {
                        let id = UserDefaults.standard.string(forKey: "id")
                        let request = Favorite(idPost: place._id, idUser: id!)
                        favoritesViewModel.deleteFavorite(request: request) { result in
                            switch result {
                            case .success(let response):
                                // Action si la connexion est réussie
                                print(response)
                                added.self=true
                                //   self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
                            }
                            print(request)
                        }
                  
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(added ? Color.white:Color.red)
                            .padding(10)
                            .font(.system(size: 40))
                        
                    }
                    
                }
             
            }
            
            HStack{
                VStack{
                    
                    
                    Text(place.nom).frame(maxWidth:  .infinity,alignment: .leading)
                    
                    
                        .foregroundColor(Color.black)
                
                        .padding(.horizontal,20)
                        .fontWeight(.bold)
                     
                    
                    if(place.rate != "No ratings"){
                        HStack{
                            Image(systemName: "star.fill")
                                .foregroundColor( .yellow )
                            let float=Float(place.rate)
                            Text(String(format:"%.2f",float!)+"/5")
                            
                                .foregroundColor(Color.black)
                            
                
                            
                            Button(action: {
                                isRatingDialogPresented = true
                            }) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .foregroundColor( .gray )
                                
                                    .frame(width: 20,height: 20)
                                
                                
                                
                            }
                            
                        }.frame(maxWidth:  .infinity,alignment: .leading)
                            .padding(.horizontal,20)
                        
                        
                    }else{
                        HStack{
                            Text(NSLocalizedString("noRatings", comment: "No ratings"))
                                .foregroundColor(Color.gray.opacity(0.5))
                            Button(action: {
                                isRatingDialogPresented = true
                            }) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .foregroundColor( .gray )
                                
                                    .frame(width: 20,height: 20)
                                
                                
                                
                            }
                            
                        } .frame(maxWidth:  .infinity,alignment: .leading)
                        
                            .padding(.horizontal,20)
                    }
                    HStack{
                        Image(systemName: "mappin.and.ellipse").foregroundColor(Color.red)
                        
                        Text(place.lieux).foregroundColor(Color.black)// Set the icon's color
                    }.frame(maxWidth:  .infinity,alignment: .leading)
                        .padding(.horizontal)
                }
                
                VStack{
                    QRCodeView(data: qrCodeData)
                        .frame(width: 100, height: 100).onAppear {
                            qrCodeData = "\(place.nom)\n\(place.lieux)\n\(place.description)"
                        }
                    
                }.padding()
            }
            
            
            
            Text("Description").frame(maxWidth:  .infinity,alignment: .leading) .foregroundColor(Color.black)           .fontWeight(.bold)     .padding(.horizontal,20)
            Text(place.description).frame(maxWidth:  .infinity,alignment: .leading)
                .foregroundColor(Color.black)
                .padding(.horizontal,20)
     
            Spacer()
            
            HStack{

            

             
        
                Button(action: {
                    isMapDialogPresented = true
                }) {
                    Image(systemName: "map.fill")
                        .foregroundColor(Color.white)
                        .padding(10)
                        .background(Circle().foregroundColor(.red))
                        .font(.system(size: 40))
                        .padding(10)
                }
                .sheet(isPresented: $isMapDialogPresented) {
                    MapDialog(place: place, isPresented: $isMapDialogPresented)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0) // add a border
                        )
                        .frame(width: 300, height: 400)
                }
       
            }
                        

            
            if isRatingDialogPresented {

                RatingDialog(place: place, isPresented: $isRatingDialogPresented)
                    
                    // set the width and height
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1) // add a border
                        ).offset(x:0,y: -250)
      
                }
            
            
        } 
        
        

        }
            


    
    
    }
    


