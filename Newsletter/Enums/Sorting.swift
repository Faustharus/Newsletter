//
//  Sorting.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 03/06/2023.
//

import Foundation

enum Sorting: String, CaseIterable {
    case publishedAt
    case revelancy
    case popularity
    
    var sortingName: String {
        switch self {
            case .publishedAt:
                return "Latest Article"
            case .revelancy:
                return "Revelancy"
            case .popularity:
                return "Popularity"
        }
    }
}
