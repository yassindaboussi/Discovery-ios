//
//  CategoryCardView.swift
//  Discovery
//
//  Created by Discovery on 13/4/2023.
//

import Foundation
import SwiftUI
struct CategoryCardView: View {
    let imageName: String
    let title: String
    @State var showModal = false

    
    var body: some View {
        VStack {
       
            GeometryReader { geo in
                if(imageName=="gif_beach"){
                    GifView(gifName: imageName)
                
                .frame(width: geo.size.width*1.8, height: geo.size.width*1.8,alignment: .center )
                }else{
                    GifView(gifName: imageName)
                
                .frame(width: geo.size.width*1.5, height: geo.size.width*1.5,alignment: .center )
                }
                 
                    
                        
            }.frame(width: 70,height: 70) .clipShape(Circle())
            Text(title)     .foregroundColor(Color.black)
        }.padding(5)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .onTapGesture {
            showModal=true
        
        }.fullScreenCover(isPresented: $showModal){
            ListPlacesByCategory(categoryTitle: title)
        }
      
    }
    
    
    
}
