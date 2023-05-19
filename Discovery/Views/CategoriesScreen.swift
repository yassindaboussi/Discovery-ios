//
//  CategoriesScreen.swift
//  Discovery
//
//  Created by Discovery on 18/4/2023.
//

import SwiftUI

struct CategoriesScreen: View {
    let Categories = [Category(gif: "gif_beach", title: "Beach"),Category(gif: "gif_desert", title: "Desert"),
                      Category(gif: "gif_nature", title: "Nature"), Category(gif: "gif_culturee", title: "Cuture"),Category(gif: "gif_food", title: "Food")]
    
    let screenWidth = UIScreen.main.bounds.width
   
    @StateObject var  categoriesViewModel=CategoriesViewModel()
    var body: some View {
        ScrollView(.vertical) {
            
            HStack{
                Text(NSLocalizedString("categories", comment: "Catgeories")).font(.system(size:30)).frame(maxWidth:.infinity, alignment:.leading).bold()
                    .padding(.bottom,5)
            }.padding(.horizontal,20)
            LazyVStack(alignment:.center,spacing: 10)  {
                ForEach(Categories, id: \.self) { categorie in
                    HStack{
                        GeometryReader { geo in
                            if(categorie.gif=="gif_beach"){
                                GifView(gifName: categorie.gif)
                            .frame(width: geo.size.width*1.8, height: geo.size.width*1.8,alignment: .center )
                            }else{
                                GifView(gifName: categorie.gif)
                            .frame(width: geo.size.width*1.5, height: geo.size.width*1.5,alignment: .center )
                            }}.frame(width: screenWidth / 4,height: screenWidth / 4) .clipShape(Circle())
                        
                        ScrollView(.horizontal) {
                         
                            LazyHStack(alignment:.center,spacing: 10)  {
                                if(categoriesViewModel.categories[categorie.title] == []){
                                    Text(NSLocalizedString("thisCategoryDoesNotContainAnySuggestion", comment: "this category does not contain any suggestion")).foregroundColor(.gray)
                                }
                                ForEach(categoriesViewModel.categories[categorie.title] ?? [], id: \.self) { place in
                            
                                    if let url = URL(string: baseUrl+"imgPosts/\(place.photo)") {
                                        
                                        AsyncImage(url:url) { phase in
                                            switch phase {
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .cornerRadius(20)
                                                    .frame(width: screenWidth / 4,height: screenWidth / 4)
                                                            .padding(6)
                                                        //  .background(Color(color.lowercased()))
                                                            .foregroundColor(.white)
                                               
                                            case .failure(let error):
                                                //Text(error.localizedDescription)
                                                Rectangle().foregroundColor(Color .gray).frame(width: screenWidth / 4)
                                        
                                                //  .background(Color(color.lowercased()))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(20)
                                            case .empty:
                                                Rectangle().foregroundColor(Color .gray).frame(width: screenWidth / 4)
                                            
                                                //  .background(Color(color.lowercased()))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(20)
                                            @unknown default:
                                                Text("Unknown error")
                                            }
                                        } } else {
                                            Text("Invalid URL")
                                        }
                                
                                }
                            }.onAppear{
                                print(categorie.title)
                                categoriesViewModel.findPlacesByCategory(category: categorie.title )
                            }
                        }
                    }
               
                }
            }.padding()
        }
    }
}

struct CategoriesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesScreen()
    }
}
