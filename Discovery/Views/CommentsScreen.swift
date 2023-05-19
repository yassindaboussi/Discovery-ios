//
//  CommentsScreen.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation
import SwiftUI
struct CommentsScreen: View {
    let postId:String
    @State var VerifLike:Bool
    @State var likes:Int
    @StateObject var  commentsViewModel=CommentsViewModel()
    @StateObject var  postsViewModel=PostsViewModel()

    var body: some View {
    

        NavigationView {
            
            ScrollView(.vertical) {
                /*if( == []){
                    Text("This category does not contain any suggestion at the moment")
                        .foregroundColor(.gray)
                }*/
                LazyVStack(alignment:.center)  {
                    ForEach(commentsViewModel.comments, id: \.self) { comment in
                        CommentItemView(comment:comment).padding()
                    }
                }
                .padding(.vertical)
            }  .safeAreaInset(edge: .top){
                VStack {
                    HStack{
                        Image(systemName: "heart.fill")// Set the icon using an SF Symbol
                            .foregroundColor(.red)
                        Text(String(likes)).foregroundColor(.gray.opacity(0.5))// Set the icon's color
                  
                        Spacer()
                        
                    }.padding()
                }   .background(Color.white)
                
            }.frame(maxWidth: .infinity,alignment: .bottom)
            .safeAreaInset(edge: .bottom){
                VStack {
                    HStack {
                        if let url = URL(string: baseUrl+"imgPosts/") {
                            AsyncImage(url:url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 50, height: 50)
                                case .failure(let error):
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.gray.opacity(0.2))
                                                .frame(width: 50, height: 50))
                                    //Text(error.localizedDescription)
                                case .empty:
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Image(systemName: "person.crop.circle.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .foregroundColor(.gray.opacity(0.2))
                                                .frame(width: 50, height: 50)
                                        )
                                @unknown default:
                                    Text("Unknown error")
                                }
                            }
                        } else {
                            Text("Invalid URL")
                        }
                     
                        TextField(NSLocalizedString("writeComment", comment: "Write comment"), text:  $commentsViewModel.comment)
                        
                            .foregroundColor(.gray)
                            .accentColor(.gray)
                            .padding(15)
                            .background(Color.gray.opacity(0.2))
                    
                            .border(Color.clear, width: 0)
                            .cornerRadius(10)
                          
                        
                       
                 
                        Rectangle()
                            .fill(.red)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(5)
                                    .overlay(
                                        Image(systemName: "paperplane")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .frame(width: 30, height: 30)
                                    )  .onTapGesture {
                                        let id = UserDefaults.standard.string(forKey: "id")
                                        print(id)
                                        let request = CommentRequest(idPost: postId, idUser: id!, content: commentsViewModel.comment)
                                        commentsViewModel.addComment(request: request) { result in
                                            switch result {
                                            case .success(let response): 
                                                // Action si la connexion est réussie
                                                commentsViewModel.getCommentsByIdPost(postId:postId  )
                                                print(response)
                                                commentsViewModel.comment=""
                                             //   self.redirectToHomePage = true // Set redirectToHomePage to true
                                            case .failure(let error):
                                                // Action si la connexion échoue
                                                print(error)
                                            }
                                        }
                                    }
                            
                      
                   
                        /*Text("What's new?")
                            .padding()
                            .frame(maxWidth:  .infinity, alignment: .leading)
                            .foregroundColor(Color.gray)
                            .clipShape(Rectangle())
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)*/
                    }
                    .padding()
                    .background(Color.white)
                }     }.frame(maxWidth: .infinity,alignment: .bottom)
            }
            .onAppear{
                commentsViewModel.getCommentsByIdPost(postId:postId  )
            }
        

        }
        }




