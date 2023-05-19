//
//  GifView.swift
//  Discovery
//
//  Created by Discovery on 17/4/2023.
//

import Foundation
import SwiftUI
import WebKit

struct GifView: UIViewRepresentable {
    let gifName: String

    init(gifName: String) {
        self.gifName = gifName
    }
    func makeUIView(context: Context) -> WKWebView{
        
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        let url=Bundle.main.url(forResource:gifName , withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webView.load(data,mimeType: "image/gif",characterEncodingName: "UTF-8",baseURL: url.deletingLastPathComponent())
        webView.contentMode = .scaleAspectFit
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}


