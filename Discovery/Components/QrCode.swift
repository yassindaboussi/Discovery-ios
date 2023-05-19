//
//  QrCode.swift
//  Discovery
//
//  Created by Discovery on 10/5/2023.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins


struct QRCodeView: View {
    let data: String
    
    var body: some View {
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(self.data.utf8)
        filter.setValue(data, forKey: "inputMessage")
        let ciImage = filter.outputImage
        
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage!, from: ciImage!.extent) else {
            fatalError("Failed to create CGImage from CIImage.")
        }
        let uiImage = UIImage(cgImage: cgImage)
        
        return Image(uiImage: uiImage)
            .interpolation(.none)
            .resizable()
            .scaledToFit()
    }
}
