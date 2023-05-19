//
//  BottomNavigation.swift
//  Discovery
//
//  Created by Discovery on 12/4/2023.
//

//

import SwiftUI

struct BottomNavigation: View {
    @State var selectedTab = "house"
    @State var isPresenting = false
    var body: some View {
    
        ZStack(alignment:Alignment(horizontal:.center, vertical: .bottom)){
    
            if selectedTab == "house" {
                HomeScreen()
            } else if selectedTab == "location" {
                CategoriesScreen()
            } else if selectedTab == "person" {
                ProfileView()
            } else if selectedTab == "heart" {
                FavoritesScreen()
            } else if selectedTab == "bubble.left.and.bubble.right" {
                PostsScreen()
            }
       
            }
        HStack{
            CustomTabBar(selectedTab: $selectedTab)
        }

 
    

    }
}

struct BottomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigation()
    }
}
