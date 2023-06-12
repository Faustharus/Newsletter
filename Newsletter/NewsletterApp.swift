//
//  NewsletterApp.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 28/05/2023.
//

import SwiftUI

@main
struct NewsletterApp: App {
    
    @StateObject var bookmarkVM = NewsBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
        }
    }
}
