//
//  OTPInputView.swift
//  Discovery
//
//  Created by Discovery on 5/4/2023.
//

import Foundation

import SwiftUI
struct OTPInputView: View {
    @Binding var otp : String
   // @State var otp: String = ""
    @FocusState private var focusedField: Int?
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<4) { index in
                TextField("", text: Binding(
                    get: {
                        getOTPCharacter(at: index)
                   
                    },
                    set: { newValue in
                        setOTPCharacter(at: index, with: newValue)
                    }
                ))
                .frame(width: 50, height: 50)
                .cornerRadius(5)
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.gray, lineWidth: 1)
                )
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .focused($focusedField, equals: index)
                .onChange(of: otp) { value in
                    if value.count == 4 {
                        focusedField = nil
                    }
                }
            }
        }
    }
    
    func getOTPCharacter(at index: Int) -> String {
        if index < otp.count {
            let otpIndex = otp.index(otp.startIndex, offsetBy: index)
           // print(String(otp[otpIndex]))
            return String(otp[otpIndex])
        }
        return ""
    }
    
    private func setOTPCharacter(at index: Int, with value: String) {
        if value.count > 1 {
            return
        }
        
        if index < otp.count {
            let otpIndex = otp.index(otp.startIndex, offsetBy: index)
            otp.replaceSubrange(otpIndex...otpIndex, with: value)
        } else if value.count == 1 {
            otp += value
            if index < 3 {
                focusedField = index + 1
            } else {
                focusedField = nil
            }
        }
    }
}




