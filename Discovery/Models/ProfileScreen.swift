//
//  ProfileScreen.swift
//  Discovery
//
//  Created by Discovery on 6/4/2023.
//

import Foundation
import SwiftUI
import WaterfallGrid

struct ProfileView: View {
    let screenWidth = UIScreen.main.bounds.width
    @State private var scrollAmount: CGFloat = .zero
    @State private var nameToHeaderDistance: CGFloat = .zero
    @State var isLogout = false
    private let originHeaderHeight: CGFloat = 150
    private let shrinkHeaderScale: CGFloat = 0.3
    private var shrinkHeaderHeight: CGFloat { originHeaderHeight * shrinkHeaderScale }
    private var minHeaderHeight: CGFloat { originHeaderHeight - shrinkHeaderHeight }
    
    private let originalIconSize: CGFloat = 80
    private let overlappingHeaderIconScale: CGFloat = 0.3
    private var overlappingHeaderIconSize: CGFloat { originalIconSize * overlappingHeaderIconScale }
    
    private let scrollAmountForProcessCompletionWhenScrolled: CGFloat = 30
    private let scrollAmountForProcessCompletionWhenPulled: CGFloat = 200
    
    let items = ["yass","logo","logoapp","changepassword","codeotp","editprofil"]
    
    @State private var isProfileVisible = false
    @StateObject var  postsViewModel=PostsViewModel()
     @StateObject  var profileViewModel = ProfileViewModel()
    @State private var id = UserDefaults.standard.string(forKey: "id")
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .top) {
           /* headerContent
                            .zIndex(1)
                            .clipped()
                            .frame(height: minHeaderHeight)*/
            
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    headerImage
                        .zIndex(scrollAmount > shrinkHeaderHeight ? 1 : 0)
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: scrollAmount > 0
                            ? originHeaderHeight
                            : originHeaderHeight - scrollAmount
                        )
                        .clipped()
                        .offset(
                            y: scrollAmount > 0
                            ? scrollAmount > shrinkHeaderHeight ? scrollAmount - shrinkHeaderHeight : 0
                            : scrollAmount
                        )
                        .background(
                            GeometryReader { geo in
                                Color.clear.preference(
                                    key: ScrollAmountPreferenceKey.self,
                                    value: geo.frame(in: .global).minY * -1
                                )
                            }
                        )
                    
                    // Body
                    VStack(alignment: .leading) {
                        HStack(alignment: .bottom) {
                            icon
                            Spacer()
                            HStack{
                                EditProfileButton
                                Button(action: {
                                    logout()
                                    
                                            }) {
                                                Image(systemName: "rectangle.portrait.and.arrow.forward")
                                                    .font(.system(size: 20))
                                                    .foregroundColor(.white)
                                                    .padding(5)
                                                    .background(Color.red)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            }
                            
                            }
                        
                        }
                        
                        profile
                        
                      /*  WaterfallGrid(postsViewModel.posts, id: \.self) { item in
                            Image(item.photo)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .clipped()
                        }
                        .gridStyle(
                            columns: 3,
                            spacing: 8,
                            animation: .easeInOut(duration: 0.5)
                        )
                        .onAppear {
                            postsViewModel.getPostssss(postedby: "64543bedc6b0eaa7bbef5fc5")
                        }
                       */
                        
                        
                     /*   LazyVGrid(columns: Array.init(repeating: GridItem(.adaptive(minimum: 160, maximum: 160)), count: 3), spacing: 28, content: {
                            ForEach(postsViewModel.posts, id: \.self) { post in
                                VStack {
                                    Image(post.photo)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(35)
                                    
                                }
                            }
                        })
                        .onAppear{
                            postsViewModel.getPostssss(postedby: "64543bedc6b0eaa7bbef5fc5")
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                        */
                        
                        
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ], spacing: 10) {
                            ForEach(postsViewModel.mypost, id: \.self) { post in
                                AsyncImage(url: URL(string: baseUrl+"imgPosts/\(post.photo)")) { image in
                                    image
                                        .resizable()
                                   
                                        .frame(width: (screenWidth / 3)-20, height: screenWidth / 3)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .onAppear {
                            
                            postsViewModel.getPostssss(postedby: id!)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)

                        
                        
                      
                        
                    }
                    .padding(.horizontal)
                    .offset(
                        y: scrollAmount > 0
                        ? -overlappingHeaderIconSize
                        : -overlappingHeaderIconSize + scrollAmount
                    )
                }
                .onPreferenceChange(ScrollAmountPreferenceKey.self) {
                    scrollAmount = $0
                    //print("scrollAmount", scrollAmount)
                }
                .onPreferenceChange(NameToHeaderSizePreferenceKey.self) {
                    nameToHeaderDistance = $0
                    //print("nameToHeaderSize", nameToHeaderDistance)
                }
            }
            
            if isProfileVisible {
                Color.black.opacity(0.6)
                    .ignoresSafeArea(.all, edges: .top)
                if let user = profileViewModel.user  {
                    EditProfileDialog(isVisible: $isProfileVisible,user:user )
                        .frame(height: 900)
                        .cornerRadius(40)
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height)
                }
                }
            
            

            
            
        }.fullScreenCover(isPresented:$isLogout, onDismiss: nil) {
            LoginScreen()
                .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
    
    private var EditProfileButton: some View {
        let buttonHeight: CGFloat = 35
        
        return Button(action: {
            withAnimation {
                isProfileVisible.toggle()
            }
            print("Edit Profile button was clicked")
        }) {
            Text("Edit Profile")
                .font(.subheadline)
                .padding(25)
                .foregroundColor(.primary)
                .frame(height: buttonHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: buttonHeight / 2)
                        .stroke(.gray, lineWidth: 1)
                )
        }
    }
    
    
    
    func logout() {
         // Clear the user's login information.
        if Bundle.main.bundleIdentifier != nil {
            UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
                UserDefaults.standard.removeObject(forKey: key)
            }
            UserDefaults.standard.synchronize()
        }
   
        isLogout=true
 
        print(id)
     
     }
    
    private var headerContent: some View {
            return VStack(alignment: .leading) {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // Handle button action here
                    }) {
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.black)
                            .opacity(0.7)
                            .overlay {
                                Image(systemName: "power")
                                    .foregroundColor(.white)
                            }
                    }
                    .padding(.trailing)
                    .padding(.bottom, 100)
                }
                .padding(.horizontal)
            }
        }

    
    private var headerImage: some View {
        let maxBlurRadiusWhenScrolled: CGFloat = 10
        let maxBlurRadiusWhenPulled: CGFloat = 30
        
        let blurRadiusWhenScrolled: CGFloat = {
            (-nameToHeaderDistance)
                .normalize(from: 0...scrollAmountForProcessCompletionWhenScrolled,
                           to: 0...maxBlurRadiusWhenScrolled)
        }()
        let blurRadiusWhenPulled: CGFloat = {
            abs(scrollAmount)
                .normalize(from: 0...scrollAmountForProcessCompletionWhenPulled,
                           to: 0...maxBlurRadiusWhenPulled)
        }()
        
        let blackTransparentBackgroundOpacity: CGFloat = {
            (-nameToHeaderDistance)
                .normalize(from: 0...scrollAmountForProcessCompletionWhenScrolled,
                           to: 0...0.5)
        }()
        
        return Image("cover")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(Color.black.opacity(blackTransparentBackgroundOpacity))
            .blur(radius: scrollAmount > 0 ? blurRadiusWhenScrolled : blurRadiusWhenPulled)
    }
    
    private var icon: some View {
        let lineWidth: CGFloat = 5
        let scale: CGFloat = 1
        - scrollAmount
            .normalize(from: 0...shrinkHeaderHeight,
                       to: 0...overlappingHeaderIconScale)
        
        return HStack {
         
            if let user = profileViewModel.user  {
                AsyncImage(url: URL(string: baseUrl + "imaguser/\(user.avatar)")) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .foregroundColor(.gray.opacity(0.5))
               
                            //.overlay(Circle().stroke(Color("Background"), lineWidth: lineWidth))
                            .scaleEffect(scale, anchor: UnitPoint(x: 0.5, y: 1))
                            .frame(width: originalIconSize, height: originalIconSize)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            //.overlay(Circle().stroke(Color("Background"), lineWidth: lineWidth))
                            .scaleEffect(scale, anchor: UnitPoint(x: 0.5, y: 1))
                            .frame(width: originalIconSize, height: originalIconSize)
                    case .failure:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                   
                            //.overlay(Circle().stroke(Color("Background"), lineWidth: lineWidth))
                            .scaleEffect(scale, anchor: UnitPoint(x: 0.5, y: 1))
                            .frame(width: originalIconSize, height: originalIconSize)
                    @unknown default:
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                        
                            //.overlay(Circle().stroke(Color("Background"), lineWidth: lineWidth))
                            .scaleEffect(scale, anchor: UnitPoint(x: 0.5, y: 1))
                            .frame(width: originalIconSize, height: originalIconSize)
                    }
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
            }
        }
    }

    


    
    private var profile: some View {
        VStack(alignment: .leading) {
            if let user = profileViewModel.user {
                Text(user.username)
                    .font(.title2.bold())
                    .background(
                        GeometryReader { geo in
                            Color.clear.preference(
                                key: NameToHeaderSizePreferenceKey.self,
                                value: geo.frame(in: .global).maxY - minHeaderHeight
                            )
                        }
                    )
                Text(user.bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                            // Autres affichages basés sur les données de l'utilisateur
                        }
         
            Spacer()
            Text("Photos")
                .font(.body)
                .frame(maxWidth: .infinity)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
            
            Divider()
                
        }.onAppear(
            perform: {
                profileViewModel.getProfile()
            }
        )
    }
}

struct ScrollAmountPreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct NameToHeaderSizePreferenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

private extension Comparable where Self == CGFloat {
    func clamp(to range: ClosedRange<Self>) -> Self {
        return max(range.lowerBound, min(range.upperBound, self))
    }
    
    func normalize(
        from originRange: ClosedRange<Self>,
        to newRange: ClosedRange<Self>
    ) -> Self {
        let normalized = (newRange.upperBound - newRange.lowerBound)
        * ((self - originRange.lowerBound) / (originRange.upperBound - originRange.lowerBound))
        + newRange.lowerBound
        
        return normalized.clamp(to: newRange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
