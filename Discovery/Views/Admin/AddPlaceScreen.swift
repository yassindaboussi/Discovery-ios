//
//  AddPlaceScreen.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//

import Foundation

import SwiftUI
import Photos

struct AddPlaceScreen: View {
    @StateObject var addPlaceViewModel=AddPlaceViewModel()
   // @State private var selectedCategory : String? = nil
   // @State private var selectedGovernorate: String? = nil

    @State private var showMenu = false
    
    @State var isShowingImagePicker = false
    @State var image: UIImage?
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            HStack{
                if let image = self.image {
                    Image(uiImage: image)
                        .resizable()
             
                        .frame( maxWidth: .infinity, maxHeight:  300)
                
                }else{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .frame( height: 200)
                        .padding(50)
                   
                        .foregroundColor(Color.white)
                }
          
            }.background(Color.gray.opacity(10))
       
            Button(action: {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    DispatchQueue.main.async {
                        switch status {
                        case .authorized:
                            self.isShowingImagePicker = true
                            break
                        case .denied, .restricted:
                            // Handle denied or restricted permission
                            break
                        case .notDetermined:
                            // Handle not determined permission
                            break
                        default:
                            break
                        }
                    }
                }
                        // Code to be executed when the button is tapped
                        print("Button tapped")
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
            }.fullScreenCover(isPresented:$isShowingImagePicker, onDismiss: nil) {
                ImagePicker(image: $image)
                    .ignoresSafeArea()
            }

            .background(Color.red)
            .clipShape(Circle())
            .padding(10)
        }
        VStack{
            Section{
                CustumTextField(placeHolder:"Title", text: $addPlaceViewModel.nom)
                .onChange(of: addPlaceViewModel.nom) { value in
                    addPlaceViewModel.validateTitle()
                }
            if let errorMessage = addPlaceViewModel.titleError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }
            
            
            HStack{
                Menu {
                            ScrollView {
                                ForEach(governorates, id: \.self) { option in
                                    Button(action: {
                                        addPlaceViewModel.lieux = option
                                        showMenu = false
                                    }) {
                                        Text(option)
                                    
                                    }  .frame(maxWidth:.infinity)
                                }
                            }
                        } label: {
                            HStack{
                                Text(  addPlaceViewModel.lieux   == "" ?  "Select governorate":addPlaceViewModel.lieux)
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                         
                            .foregroundColor(  addPlaceViewModel.lieux == "" ?Color.gray:Color.black)
                              
                                .frame(maxWidth:.infinity, alignment:.leading)
                        }.padding()
           
     
           
                       
                
            }    .frame(maxWidth:.infinity)
                .overlay(RoundedCorners(tl: 20, tr: 5, bl: 5, br: 20).stroke(lineWidth: 1).foregroundColor(.gray))
            
            HStack{
                Menu {
                            ScrollView {
                                ForEach(categories, id: \.self) { option in
                                    Button(action: {
                                        addPlaceViewModel.categorie  = option
                                        showMenu = false
                                    }) {
                                        HStack{
                                            Text(option)
                                        }
                                    
                                    }  .frame(maxWidth:.infinity)
                                }
                            }
                        } label: {
                            HStack{
                                Text(    addPlaceViewModel.categorie  == "" ? "Select Category": addPlaceViewModel.categorie )
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                         
                            .foregroundColor(    addPlaceViewModel.categorie == "" ?Color.gray:Color.black)
                              
                                .frame(maxWidth:.infinity, alignment:.leading)
                        }.padding()
           
     
           
                       
                
            }    .frame(maxWidth:.infinity)
                .overlay(RoundedCorners(tl: 20, tr: 5, bl: 5, br: 20).stroke(lineWidth: 1).foregroundColor(.gray))
            

                
            Section{
                CustumTextField(placeHolder:"Description", text: $addPlaceViewModel.description)
                .onChange(of: addPlaceViewModel.description) { value in
                    addPlaceViewModel.validateDescription()
                }
            if let errorMessage = addPlaceViewModel.descriptionError {
                Text(errorMessage)
                    .foregroundColor(.red).font(.system(size:12)).frame(maxWidth:.infinity, alignment:.leading)
            }   }
      
            
            
            
            
            Button(action: {
           
                addPlaceViewModel.addPlace(photo:image!, nom: addPlaceViewModel.nom
                                           , lieux:     addPlaceViewModel.lieux, categorie:    addPlaceViewModel.categorie , description: addPlaceViewModel.description) { result in
                    switch result {
                    case .success(_):
                    print("succes")
                    
                                  
                                    

                     //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }
                }
            }) {
                Text("ADD")
                    .padding()
                    .foregroundColor(Color.white)
                
                
                
            }    .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
                .padding(.top,20)
            
        }.padding()
        


       
        
     
    }
}

struct AddPlace_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceScreen()
    }
}
