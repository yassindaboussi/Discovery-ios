//
//  TabView.swift
//  Discovery
//
//  Created by Discovery on 12/4/2023.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab = "Yeni Mesajlar"
    @Binding var pages: [TabBarPage]
    init(pages: Binding<[TabBarPage]>) {
        UITabBar.appearance().isHidden = true
        self._pages = pages
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            
            TabView(selection: $selectedTab) {
                
                ForEach(pages) { item in
                    AnyView(_fromValue: item.page)
                        
                        .tabItem{
                            EmptyView()
                        }.tag(item.tag)
                }
            }
            
            HStack {
                ForEach(pages) { item in
                    Button(action: {
                        self.selectedTab = item.tag
                    }) {
                        ZStack {

                            
                            Image(systemName: item.icon)
                                .foregroundColor(item.color)
                                .imageScale(.large)
                                .padding(7)
                                .background(self.selectedTab == item.tag ? Color.gray : item.color )
                                .mask(Circle())
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }

        }
        
        
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(pages: .constant([TabBarPage(page: SignUpScreen(), icon: "arrow.up.message.fill", tag: "Yeni Mesajlar", color: .green),
                                     TabBarPage(page: LoginScreen(), icon: "message.fill", tag: "Mesajlar", color: .yellow),
                                     TabBarPage(page: ProfileView(), icon: "person.crop.circle.fill", tag: "Profil", color: .blue)]))
    }
}

struct TabBarPage: Identifiable {
    var id = UUID()
    var page: Any
    var icon: String
    var tag: String
    var color: Color
}
