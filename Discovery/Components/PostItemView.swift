//
//  PostItemView.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import SwiftUI

struct PostItemView: View {
    let post:Post
    @StateObject var  commentsViewModel=CommentsViewModel()
    @StateObject var  postsViewModel=PostsViewModel()
    @State var showModal = false


    @State var  VerifLike=false
    @State var  likes = 0
    var body: some View {
        VStack {
            HStack(){
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
                Text(post.postedby.username)
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                
            }.frame(maxWidth:  .infinity,alignment: .leading)
            HStack{             Text(post.description)
                .foregroundColor(Color.black)}.frame(maxWidth:  .infinity,alignment: .leading)
            HStack{
                
                
                if let url = URL(string: baseUrl+"imgPosts/\(post.photo)") {
                    
                    AsyncImage(url:url) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                            
                            
                                .clipShape(Rectangle())
                            
                        case .failure(let error):
                            Rectangle().foregroundColor(Color .gray.opacity(0.5))
                            //Text(error.localizedDescription)
                        case .empty:
                            Rectangle().foregroundColor(Color .gray.opacity(0.5))
                        @unknown default:
                            Text("Unknown error")
                        }
                    }.frame(height:250) } else {
                        Text("Invalid URL")
                    }
                
            }
            HStack{
                
                
                
                if(VerifLike==false){
                    Button(action: {
                        let id = UserDefaults.standard.string(forKey: "id")
            
                         let request = Like(idPost: post._id, idUser: id!)
                         postsViewModel.addLike(request: request) { result in
                            switch result {
                            case .success(let response):
                                // Action si la connexion est réussie
                             
                                VerifLike=true
                                likes+=1
                             //   self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
        
                            }
                         }
                  
                    }) {
                 
                            Image(systemName: "heart.fill")
                                .foregroundColor(VerifLike ? Color.red:Color.gray)
                       
               
                        
                    }
                    
                  
               
                }else{
                    Button(action: {
                        let id = UserDefaults.standard.string(forKey: "id")
                        let request = Like(idPost: post._id, idUser: id!)
                        postsViewModel.deleteLike(request: request) { result in
                            switch result {
                            case .success(let response):
                                likes-=1
                              VerifLike=false
                                //   self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
                            }
                            print(request)
                        }
                  
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(VerifLike ? Color.red:Color.gray)
                       
                    }
                    
                }
             
                
                Text(String(likes)).foregroundColor(.gray.opacity(0.5))// Set the icon's color
            
 
                Spacer()
                HStack{
                    HStack{Image(systemName: "ellipsis.bubble")// Set the icon using an SF Symbol
                        .foregroundColor(.gray.opacity(0.5))
                    Text("\(commentsViewModel.count) Comments").foregroundColor(.gray.opacity(0.5))// Set the icon's color
                    }
                        .onTapGesture {
                            showModal=true
                            
                        }.sheet(isPresented: $showModal){
                            CommentsScreen(postId: post._id,VerifLike: VerifLike,likes: likes).frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
            
                    Spacer()
                }
            }.onAppear {
                commentsViewModel.getCommentsByIdPost(postId: post._id)
                let id = UserDefaults.standard.string(forKey: "id")
                let request = Like(idPost: post._id, idUser: id!)
                postsViewModel.verifLike(request: request) { result in
                    switch result {
                    case .success(let response):
                        // Action si la connexion est réussie
                
                        if(response.message=="Exist!"){
                            VerifLike=true
                        }else{
                            VerifLike=false
                        }
                        
                        //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }
                    print(post._id)
                    print(VerifLike)
                }
                postsViewModel.countLikesByPost(postId: post._id){ result in
                    switch result {
                    case .success(let response):
                        // Action si la connexion est réussie
                        likes=response.count
                        
                        //   self.redirectToHomePage = true // Set redirectToHomePage to true
                    case .failure(let error):
                        // Action si la connexion échoue
                        print(error)
                    }
                    print(post._id)
                    print(VerifLike)
                }
            }
            .padding().background(Color.white)
        }.padding()
        .background(Color.white)}}



import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var showShareSheet = false
    
    var body: some View {
        VStack {
            Text("Hello, world!")
            Button("Share") {
                showShareSheet.toggle()
            }
        }
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(activityItems: [takeScreenshot()])
        }
    }
    
    func takeScreenshot() -> UIImage {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        let view = window?.rootViewController?.view
        
        let renderer = UIGraphicsImageRenderer(size: view!.bounds.size)
        let image = renderer.image { context in
            view!.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to update
    }
}
