//
//  Language.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 01/06/2023.
//

import Foundation

enum Language: String, CaseIterable {
    case en, fr, it
    
    var languageName: String {
        switch self {
            case .en:
                return "English 🇬🇧"
            case .fr:
                return "French 🇫🇷"
            case .it:
                return "Italian 🇮🇹"
            
        }
    }
}
