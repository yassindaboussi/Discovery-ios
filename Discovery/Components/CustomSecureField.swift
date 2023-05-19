//
//  CustomSecureField.swift
//  Discovery
//
//  Created by Discovery on 21/3/2023.
//

import Foundation
import SwiftUI

struct PasswordView: View {
    
    var leftIcon : String

    var placeHolder : LocalizedStringKey

    
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
    
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @Binding var password: String
    @State private var secured = true
    
    @FocusState private var focusField : Field?
    var body: some View {
        ZStack(alignment : .leading) {
            HStack{
                
                Image(systemName: leftIcon)
                    .foregroundColor(Color.secondary)
                if secured{
                    SecureField(placeHolder,text:$password)
                    
            
                    }
            
                else{
                    TextField(placeHolder, text: $password) { status in
                        
                    }
                    .focused($focusField, equals: .fieldName)
                    
                }
                Button {
                    secured.toggle()
                } label: {
                    Image(systemName: secured ? "eye.slash" : "eye")
                }
                .buttonStyle(BorderlessButtonStyle())
            }.padding()
                .overlay(RoundedCorners(tl: 20, tr: 5, bl: 5, br: 20).stroke(lineWidth: 1).foregroundColor(.gray))
 
        }
    } }
