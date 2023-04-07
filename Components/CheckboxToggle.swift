//
//  CheckboxToggle.swift
//  Discovery
//
//  Created by Discovery on 1/4/2023.
//

import Foundation
import SwiftUI
struct CheckboxToggle: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            self.isChecked.toggle()
        }) {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .black : .gray)
                Text("Remember me").foregroundColor(.black )
            }
        }
    }
}
