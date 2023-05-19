//
//  ListPlacesByCategory.swift
//  Discovery
//
//  Created by Discovery on 18/4/2023.
//

import SwiftUI

struct ListPlacesByCategory: View {
    let categoryTitle: String
    @StateObject var  categoriesViewModel=CategoriesViewModel()
    @Environment(\.presentationMode) var presentationMode
    let screenWidth = UIScreen.main.bounds.width
    let columns = [        GridItem(.flexible()),        GridItem(.flexible())    ]
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                if(categoriesViewModel.categories[categoryTitle] == []){
                    Text(NSLocalizedString("thisCategoryDoesNotContainAnySuggestion", comment: "this category does not contain any suggestion")).foregroundColor(.gray)
                }
                LazyVGrid(columns:columns,spacing: 20) {
                    ForEach(categoriesViewModel.categories[categoryTitle] ?? [], id: \.self) { place in
                        PlaceCardView(place:  place)
                                        .frame(width: (screenWidth / 2)-20, height: screenWidth / 2)
                               
                                        .foregroundColor(.white)
                                   
                                }
                }.padding(.vertical)
                .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading:
                                            Button(action: {

                        
                  
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        
                        Image(systemName: "chevron.left").foregroundColor(Color.black)
                        Text(categoryTitle).foregroundColor(Color.black)
                        
                    }
                    )
             

                }.onAppear{
                    
                    categoriesViewModel.findPlacesByCategory(category: categoryTitle )
                }
            }
        }
}


