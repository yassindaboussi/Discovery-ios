//
//  CommentItem.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation

import SwiftUI

struct CommentItemView: View {
    let comment:Comment
    @StateObject var  commentsViewModel=CommentsViewModel()
    @State var showModal = false
    var body: some View {
        HStack(alignment: .top) {
            if let url = URL(string: baseUrl+"imguser/\(comment.userId.avatar)") {
                
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
                                            .frame(width: 50, height: 50)
                                    )
                        /*Text(error.localizedDescription)*/
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
                } } else {
                    Text("Invalid URL")
                }
            Text(comment.content).padding().frame(maxWidth:  .infinity,alignment: .leading)
        
                .clipShape(Rectangle()).background(Color.gray.opacity(0.2)).cornerRadius(10)
        }
        .background(Color.white)}}


