//
//  HomeScreen.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//

import SwiftUI

struct HomeScreen: View {
    let Categories = [Category(gif: "gif_beach", title: "Beach"),Category(gif: "gif_desert", title: "Desert"),
                      Category(gif: "gif_nature", title: "Nature"), Category(gif: "gif_culturee", title: "Cuture"),Category(gif: "gif_food", title: "Food")]
    @State private var search=""
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    let items = Array(1...50)
        let columns = [        GridItem(.flexible()),        GridItem(.flexible())    ]
    @StateObject var  homeViewModel=HomeViewModel()
    let role = UserDefaults.standard.string(forKey: "role")

    @State var showPopUp = false

    
    var body: some View {
       
        ScrollView(.vertical) {
            VStack(alignment:.center){
                
                HStack{
                    Text(NSLocalizedString("whatAreYouLookingFor", comment: "What are you looking for?")).font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading).bold()
                        .padding(.bottom,5)
                }.padding(.horizontal,20)
                
                HStack{
                    TextFieldView(leftIcon:"magnifyingglass",placeHolder : NSLocalizedString("search", comment: "Search"), text: $search)
                }.padding()
                
                
                
                ScrollView(.horizontal) {
                    LazyHStack(alignment:.center,spacing: 10)  {
                        ForEach(Categories, id: \.self) { categorie in
                            CategoryCardView(imageName: categorie.gif, title:categorie.title).frame(width: screenWidth / 5)
                                .padding(6)
                            //  .background(Color(color.lowercased()))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                HStack{
          
                    Text(role != "User" ? NSLocalizedString("categories", comment: "Categories"):NSLocalizedString("recommended", comment: "Recommended")).font(.system(size:20)).frame(maxWidth:.infinity, alignment:.leading).bold()
                        .padding(.bottom,5)
            
                }.padding(.horizontal,20)
                ScrollView(.vertical) {
                LazyVGrid(columns:columns,spacing: 20) {
                    ForEach(homeViewModel.places.prefix(10).filter({ search.isEmpty ? true : $0.lieux.localizedStandardContains(search)||$0.nom.localizedStandardContains(search)  }), id: \.self) { place in
                        PlaceCardView(place:  place)
                                        .frame(width: (screenWidth / 2)-20, height: screenWidth / 2)
                               
                                        .foregroundColor(.white)
                                   
                    }
                    

                }
                .onAppear{
                    homeViewModel.fetchPlaces(){ _ in
                        
                    }
                }   }
                
                

                
            }
          /*  .toolbar {
                if role == "Admin" {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Handle settings button tap
                        }) {
                            Button(action: {
                                // Handle button tap
                            }) {
                                Text(NSLocalizedString("post", comment: "Post"))
                                    .padding(10)
                                    .foregroundColor(Color.white)
                            }
                        }
                    }
                }
            }*/
                
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .overlay(
                Group{
                    if(role == "Admin")
                    {
                        Button(action: {
                            showPopUp = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .padding()
                                .background(Color(.red).opacity(0.1).shadow(radius: 2))
                                .cornerRadius(50)
                        }
                        .background(Color.clear)
                        .position(x: screenWidth - 50, y: screenHeight - 100)
                        .onTapGesture {
                            withAnimation {
                                showPopUp.toggle()
                            }
                        }
                    }
                }
            )
            
            if showPopUp {
                PlusMenu()
            }
    

        
    }
    
    
    struct PlusMenu: View {


        @State private var isActive = false
        @State private var isLogout = false

        var body: some View {
            HStack(spacing: 50) {
                Button(action: {
                    if Bundle.main.bundleIdentifier != nil {
                        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
                            UserDefaults.standard.removeObject(forKey: key)
                        }
                        UserDefaults.standard.synchronize()
                    }

                    isLogout=true
                   })
                   {
                    ZStack {
                        Circle()
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 50)
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(15)
                            .foregroundColor(.black)
                            .frame(width: 50, height: 50)

                    }
                }
                
                Button(action: {
                    isActive = true
                }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.brown)
                                .frame(width: 50, height: 50)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(15)
                                .foregroundColor(.black)
                                .frame(width: 50, height: 50)

                        }
                    
                }
                NavigationLink(destination: AddPlaceScreen(), isActive: $isActive) {EmptyView()}

            }
            .fullScreenCover(isPresented:$isLogout, onDismiss: nil) {
                LoginScreen()
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
    }
}







struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}




