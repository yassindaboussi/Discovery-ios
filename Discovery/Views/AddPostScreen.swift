//
//  AddPostScreen.swift
//  Discovery
//
//  Created by Discovery on 12/4/2023.
//

import SwiftUI
import Photos
import Combine

struct AddPostScreen: View {
    @StateObject var addPostViewModel = AddPostViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var isShowingImagePicker = false
    @State var image: UIImage?
    @State var showModal = false
    let textLimit = 255 //Your limit
    var body: some View {
        NavigationView {
      

           
            
            VStack {
                TextField(NSLocalizedString("typeSomethingCoolHere", comment: "Type something cool here !"), text: $addPostViewModel.inputText,axis: .vertical)   .onReceive(Just(addPostViewModel.inputText)) { _ in limitText(textLimit) }
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 100)
                    .lineLimit(5...10)
                    .padding(20)
                
                
                
    
                        
           Spacer()
             
               
                    if let image = self.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                    
                    }
               
                    
            
            
                HStack{
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
                                Image(systemName: "photo").resizable().frame(width: 30,height: 30)// Set the icon using an SF Symbol
                                    .foregroundColor(.gray)
                                Text(NSLocalizedString("photo", comment: "Photo")).foregroundColor(Color.black)// Set the icon's color
                            } .fullScreenCover(isPresented:$isShowingImagePicker, onDismiss: nil) {
                                ImagePicker(image: $image)
                                    .ignoresSafeArea()
                            }
           
                    Spacer()
                    
        

                    Text("\(0 + addPostViewModel.inputText.count)/255")
                                    .foregroundColor(.gray)
                                    .padding()
                                  }
                .frame(maxWidth:.infinity,alignment: .leading )
                .padding(.leading, 20)
                .padding(.bottom, 10)
                .padding(.top, 10)
                
                
            }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                                        Button(action: {
     
                    
              
                    presentationMode.wrappedValue.dismiss()
                }) {
                    
                    Image(systemName: "chevron.left").foregroundColor(Color.black)
                    Text(NSLocalizedString("back", comment: "Back")).foregroundColor(Color.black)
                    
                }
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Handle settings button tap
                        }) {
                            Button(  action: {
                
                                addPostViewModel.uploadPost(image: image!,description: addPostViewModel.inputText) { result in
                                    switch result {
                                    case .success(_): 
                                    print("succes")
                                        self.showModal=true
                                
                                    //    presentationMode.wrappedValue.dismiss()
                                                    

                                     //   self.redirectToHomePage = true // Set redirectToHomePage to true
                                    case .failure(let error):
                                        // Action si la connexion échoue
                                        print(error)
                                    }
                                }
                                
                            }) {
                                Text(NSLocalizedString("post", comment: "Post"))
                                    .padding(10)
                                    .foregroundColor(Color.white)
                                
                                
                                
                            }.background(addPostViewModel.inputText.isEmpty ? Color.gray.opacity(0.5) :Color.red)
                                .cornerRadius(10)
                            
                                .foregroundColor(Color.gray)
                            
                        }
                        .disabled(addPostViewModel.inputText.isEmpty).fullScreenCover(isPresented: $showModal){
                            BottomNavigation(selectedTab:"bubble.left.and.bubble.right" )
                        }
                    }
                }
        
        }
        
        
        
        
    }
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if  addPostViewModel.inputText.count > upper {
            addPostViewModel.inputText = String(addPostViewModel.inputText.prefix(upper))
        }
    }
}

struct AddPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPostScreen()
    }
}

