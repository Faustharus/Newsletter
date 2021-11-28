//
//  PreviewProvider.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 24/11/2021.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DevelopperPreview {
        return DevelopperPreview.instance
    }
    
}

class DevelopperPreview {
    
    static let instance = DevelopperPreview()
    private init() {  }
    
    let news = Article(title: "Hacking with Swift", articleDescription: "SwiftUI by Example is the world's largest collection of SwiftUI examples, tips, and techniques giving you almost 600 pages of hands-on code to help you build apps, solve problems, and understand how SwiftUI really works.", url: "https://www.hackingwithswift.com/100/swiftui", urlToImage: "https://www.hackingwithswift.com/img/paul.png", content: "")
    
}
