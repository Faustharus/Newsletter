//
//  Category.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 31/05/2023.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case technology
    case entertainment
    case sports
    case health
    case science
    case business
    
    var categoryName: String {
        switch self {
            case .general:
                return "Headlines"
            case .technology:
                return "Technology"
            case .entertainment:
                return "Entertainment"
            case .sports:
                return "Sports"
            case .health:
                return "Health"
            case .science:
                return "Science"
            case .business:
                return "Business"
        }
    }
}
