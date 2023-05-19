//
//  FavoritesScreen.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import SwiftUI

struct FavoritesScreen: View {
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    @StateObject var  favoritesViewModel=FavoritesViewModel()
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment:.center){
                HStack{
                    Text(NSLocalizedString("myFavorites", comment: "My favorites")).font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading).bold()
                        .padding(.bottom,5)
                }.padding(.horizontal,20)
   
                LazyVGrid(columns:columns,spacing: 20) {
                    if(favoritesViewModel.places == []){
                        Text("vvv").foregroundColor(.gray)
                    }
                    ForEach(favoritesViewModel.places, id: \.self) { place in
                        PlaceCardView(place:  place)
                                        .frame(width: (screenWidth / 2)-20, height: screenWidth / 2)
                               
                                         .foregroundColor(.white)
                                   
                                }
                }
                .onAppear{
                    favoritesViewModel.fetchPlaces(){ _ in
                        
                    }
                  }
            }}.frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesScreen()
    }
}
