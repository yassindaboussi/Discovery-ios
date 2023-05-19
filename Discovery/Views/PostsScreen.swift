//
//  PostsScreen.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import SwiftUI

struct PostsScreen: View {
    @StateObject var  postsViewModel=PostsViewModel()
    @State var username = ""
    @State var showModal = false
    @State var shouldRefresh = false
    var body: some View {
        ScrollView(.vertical) {
            HStack{
                
                      if let url = URL(string: baseUrl+"imgPosts/") {
                          
                          AsyncImage(url:url) { phase in
                              switch phase {
                              case .success(let image):
                                  image
                                      .resizable()
                                  
                              
                                      .clipShape(Circle())          .frame(width: 50, height: 50)
                      
                              case .failure(let error):
                                  Circle()
                                      .fill(.gray.opacity(0.5))
                                              .frame(width: 50, height: 50)
                                              .overlay(
                                                  Image(systemName: "person.crop.circle.fill")
                                                      .resizable()
                                                      .scaledToFit()
                                                      .foregroundColor(.white)
                                                      .frame(width: 50, height: 50))
                                  //Text(error.localizedDescription)
                              case .empty:
                                  Circle()
                                      .fill(.gray.opacity(0.5))
                                              .frame(width: 50, height: 50)
                                              .overlay(
                                                  Image(systemName: "person.crop.circle.fill")
                                                      .resizable()
                                                      .scaledToFit()
                                                      .foregroundColor(.white)
                                                      .frame(width: 50, height: 50)
                                              )
                              @unknown default:
                                  Text("Unknown error")
                              }
                          }} else {
                              Text("Invalid URL")
                          }
                Text(NSLocalizedString("whatNew", comment: "What new?")).padding().frame(maxWidth:  .infinity,alignment: .leading)
                    .foregroundColor(Color.gray)
                    .clipShape(Rectangle()).background(Color.gray.opacity(0.1)).cornerRadius(10)
             
                    .onTapGesture {
                        showModal=true
                       
                    }.fullScreenCover(isPresented: $showModal){
                        AddPostScreen()
                    }
            }.padding()
            .background(Color.white)

            LazyVStack(alignment:.center)  {
                ForEach(postsViewModel.posts, id: \.self) { post in
                    PostItemView(post:post, VerifLike: true)
                    
    
                        
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            
            
        }.onAppear{
            postsViewModel.fetchPosts()
        }.padding(5).background(Color.gray.opacity(0.1))
    }
    
    struct PostsScreen_Previews: PreviewProvider {
        static var previews: some View {
            PostsScreen()
        }
    }
}
