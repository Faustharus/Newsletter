//
//  NewsletterApp.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 22/11/2021.
//

import SwiftUI

@main
struct NewsletterApp: App {
    @StateObject private var vm = NewsletterViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
