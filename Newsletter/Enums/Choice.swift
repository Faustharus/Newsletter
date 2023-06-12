//
//  Choice.swift
//  Newsletter
//
//  Created by Damien Chailloleau on 05/06/2023.
//

import Foundation

enum Choice: String, CaseIterable {
    case names
    case sources
    
    var searchInCategory: String {
        switch self {
            case .names:
                return "By Name"
            case .sources:
                return "By Sources"
        }
    }
}
