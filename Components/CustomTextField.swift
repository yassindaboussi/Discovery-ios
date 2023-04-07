//
//  CustomTextField.swift
//  Discovery
//
//  Created by Discovery on 21/3/2023.
//

import Foundation
import SwiftUI



struct TextFieldView : View {
    var leftIcon : String
    var rightIcon : String? = nil
    var placeHolder : String
    
    @Binding var text : String
    
    @State private var isEditing = false
    @State private var edges = EdgeInsets(top: 0, leading:45, bottom: 0, trailing: 0)
    
    
    private enum Field : Int, Hashable {
        case fieldName
    }
    
    @FocusState private var focusField : Field?
    
    var body: some View {
        ZStack(alignment : .leading) {
            HStack {
            
                    Image(systemName: leftIcon)
                        .foregroundColor(Color.secondary)
            
                TextField(placeHolder, text: $text)
            
                .focused($focusField, equals: .fieldName)
                
                if(rightIcon != nil){
                    Image(systemName: rightIcon ?? "person")
                        .foregroundColor(Color.secondary)
                }
            }
            .padding()
            .overlay(RoundedCorners(tl: 20, tr: 5, bl: 5, br: 20).stroke(lineWidth: 1).foregroundColor(.gray))
            

        }
    }
}
