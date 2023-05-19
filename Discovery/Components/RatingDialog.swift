//
//  RatingDialog.swift
//  Discovery
//
//  Created by Discovery on 27/4/2023.
//

import Foundation
import SwiftUI

    import SwiftUI

    struct RatingDialog: View {
        let place:Place
        @Binding var isPresented: Bool
        @StateObject var ratingViewModel = RatingViewModel()
        var onRatingUpdate: ((Int) -> Void)?

        var body: some View {
            VStack {
                Text("Rate this place")
                    .font(.title)
                    .foregroundColor(.black)
                Spacer()
                StarRatingView(rating: $ratingViewModel.rating, onRatingUpdate: { rating in
                    onRatingUpdate?(rating)
                })
                Spacer()

                HStack {
                    Button("Cancel") {
                        isPresented = false
                    }
                    .foregroundColor(.black)
                    Button("Submit") {
                        let id = UserDefaults.standard.string(forKey: "id")
                        let request = RatingRequest(idPost: place._id, idUser: id!, rating: String(ratingViewModel.rating))
                        ratingViewModel.addRating(request: request) { result in
                            switch result {
                            case .success(let response):
                                isPresented = false
                                onRatingUpdate?(ratingViewModel.rating)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(.red)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .onAppear {
                let id = UserDefaults.standard.string(forKey: "id")
                ratingViewModel.getratingByUserId(postId: place._id, userId: id!)
            }
        }
    }

    struct StarRatingView: View {
        @Binding var rating: Int
        var onRatingUpdate: ((Int) -> Void)?

        var body: some View {
            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .foregroundColor(index <= rating ? .yellow : .gray)
                        .onTapGesture {
                            rating = index
                            onRatingUpdate?(rating)
                        }
                }
            }
            .font(.title)
        }
    }

  
