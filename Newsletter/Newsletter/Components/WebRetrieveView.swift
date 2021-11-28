//
//  WebRetrieveView.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 27/11/2021.
//

import Foundation
import SwiftUI
import WebKit

struct WebRetrieveView: UIViewRepresentable {
    
    var url: String
    
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Upload the View
    }
}

