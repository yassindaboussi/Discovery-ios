//
//  CustomTabBar.swift
//  Discovery
//
//  Created by Discovery on 12/4/2023.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab:String
    var body: some View {
        HStack(spacing: 0){
            
            TabBarButton(image: "house", selectedTab: $selectedTab)
            TabBarButton(image: "location", selectedTab: $selectedTab)
            TabBarButton(image: "bubble.left.and.bubble.right", selectedTab: $selectedTab)
            TabBarButton(image: "heart", selectedTab: $selectedTab)
            TabBarButton(image: "person", selectedTab: $selectedTab)
        }
        .padding()
        .background(Color.red)
        .cornerRadius(30)
        .padding(.horizontal)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigation()
    }
}



struct TabBarButton: View {
    var image:String
    @Binding var selectedTab:String
    var body: some View {
        GeometryReader{reader in
            
            
            Button(action: {
                withAnimation{
                    selectedTab = image}
            }, label:{
                Image(systemName:"\( image)\(selectedTab==image ? ".fill":"")")
                    .font(.system(
                    size: 25,weight: .semibold
                ))   .foregroundColor(Color.white)
           
                //  .offset(y:selectedTab == image? -10:0)
                
            }).frame(maxWidth: .infinity,maxHeight: .infinity)
            
            
            
        }
        .frame(height: 40,alignment: .center)
    }
}
